import UIKit

final class SongFormViewController: StackViewController {
    private let store: SongStore
    private let existingSong: Song?
    private let titleField = UITextField()
    private let artistField = UITextField()
    private let albumField = UITextField()
    private let ratingSlider = UISlider()
    private let ratingLabel = Theme.label("", style: .headline)
    private let notesField = UITextView()

    init(store: SongStore, song: Song? = nil) {
        self.store = store; self.existingSong = song
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("Use init(store:song:)") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = existingSong == nil ? "Add Song" : "Edit Song"
        navigationItem.largeTitleDisplayMode = .never
        stack.spacing = 16
        stack.addArrangedSubview(Theme.label("Log a listen", style: .title1))
        stack.addArrangedSubview(Theme.label("Give a song a place in your collection.", style: .subheadline))
        addField(titleField, label: "Song title", value: existingSong?.title, id: "songTitle")
        addField(artistField, label: "Artist", value: existingSong?.artist, id: "songArtist")
        addField(albumField, label: "Album (optional)", value: existingSong?.album, id: "songAlbum")
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 10
        ratingSlider.value = Float(existingSong?.rating ?? 7)
        ratingSlider.accessibilityLabel = "Your rating"
        ratingSlider.addTarget(self, action: #selector(ratingChanged), for: .valueChanged)
        stack.addArrangedSubview(ratingLabel)
        stack.addArrangedSubview(ratingSlider)
        ratingChanged()
        stack.addArrangedSubview(Theme.label("Listening notes (optional)", style: .headline))
        notesField.font = .preferredFont(forTextStyle: .body)
        notesField.adjustsFontForContentSizeCategory = true
        notesField.backgroundColor = .white
        notesField.textColor = Theme.ink
        notesField.layer.cornerRadius = 8
        notesField.text = existingSong?.notes
        notesField.accessibilityLabel = "Listening notes"
        notesField.translatesAutoresizingMaskIntoConstraints = false
        notesField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stack.addArrangedSubview(notesField)
        stack.addArrangedSubview(Theme.button("Save Song", id: "saveSong") { [weak self] in self?.save() })
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [UIBarButtonItem(systemItem: .flexibleSpace),
                         UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))]
        [titleField, artistField, albumField].forEach { $0.inputAccessoryView = toolbar }
        notesField.inputAccessoryView = toolbar
    }

    private func addField(_ field: UITextField, label: String, value: String?, id: String) {
        let group = UIStackView(arrangedSubviews: [Theme.label(label, style: .headline), field])
        group.axis = .vertical
        group.spacing = 8
        field.borderStyle = .roundedRect
        field.backgroundColor = .white
        field.textColor = Theme.ink
        field.font = .preferredFont(forTextStyle: .body)
        field.adjustsFontForContentSizeCategory = true
        field.placeholder = label
        field.text = value
        field.accessibilityIdentifier = id
        field.accessibilityLabel = label
        field.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        stack.addArrangedSubview(group)
    }

    @objc private func dismissKeyboard() { view.endEditing(true) }
    @objc private func ratingChanged() {
        ratingLabel.text = "Your rating: \(String(format: "%.1f", ratingSlider.value)) / 10"
        ratingSlider.accessibilityValue = String(format: "%.1f out of 10", ratingSlider.value)
    }

    private func save() {
        let title = (titleField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let artist = (artistField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty, !artist.isEmpty else {
            let alert = UIAlertController(title: "Add song details", message: "Enter a song title and artist before saving.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        store.save(Song(id: existingSong?.id ?? UUID(), title: title, artist: artist,
                        album: albumField.text ?? "", rating: (Double(ratingSlider.value) * 10).rounded() / 10,
                        notes: notesField.text ?? ""))
        navigationController?.popViewController(animated: true)
    }
}

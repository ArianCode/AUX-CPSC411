import UIKit

final class SongDetailViewController: StackViewController {
    private let store: SongStore
    private let songID: UUID
    private let songTitle = Theme.label("", style: .title1)
    private let artist = Theme.label("", style: .title3)
    private let album = Theme.label("")
    private let rating = Theme.label("", style: .title2)
    private let notes = Theme.label("")

    init(store: SongStore, songID: UUID) {
        self.store = store; self.songID = songID
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("Use init(store:songID:)") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Song Detail"
        for item in [Theme.artwork(), songTitle, artist, album, rating,
                     Theme.label("Listening notes", style: .headline), notes] {
            stack.addArrangedSubview(item)
        }
        stack.addArrangedSubview(Theme.button("Edit Song", id: "editSong") { [weak self] in
            guard let self, let song = store.song(id: songID) else { return }
            navigationController?.pushViewController(SongFormViewController(store: store, song: song), animated: true)
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let song = store.song(id: songID) else { return }
        songTitle.text = song.title
        artist.text = song.artist
        album.text = "Album: \(song.album.isEmpty ? "Not specified" : song.album)"
        rating.text = "\(String(format: "%.1f", song.rating)) / 10"
        rating.textColor = Theme.accent
        notes.text = song.notes.isEmpty ? "No listening notes yet." : song.notes
    }
}

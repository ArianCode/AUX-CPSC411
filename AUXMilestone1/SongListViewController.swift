import UIKit

final class SongListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let store: SongStore
    private let table = UITableView(frame: .zero, style: .plain)
    private var songs: [Song] = []

    init(store: SongStore) { self.store = store; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { fatalError("Use init(store:)") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Rankings"
        view.backgroundColor = Theme.background
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSong))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "listAddSong"
        let hint = Theme.label("Your collection, highest rated first. Tap a song to see more.", style: .subheadline)
        hint.translatesAutoresizingMaskIntoConstraints = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = Theme.background
        table.dataSource = self
        table.delegate = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 85
        table.register(UITableViewCell.self, forCellReuseIdentifier: "SongCell")
        table.accessibilityIdentifier = "rankingsTable"
        view.addSubview(hint)
        view.addSubview(table)
        NSLayoutConstraint.activate([
            hint.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            hint.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            hint.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            table.topAnchor.constraint(equalTo: hint.bottomAnchor, constant: 20),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        songs = store.ranked
        table.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { songs.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(indexPath.row + 1).  \(song.title)"
        content.secondaryText = "\(song.artist) · \(String(format: "%.1f", song.rating))/10"
        content.image = UIImage(systemName: "music.note.list")
        content.imageProperties.tintColor = Theme.accent
        content.textProperties.color = Theme.ink
        content.textProperties.numberOfLines = 0
        content.secondaryTextProperties.numberOfLines = 0
        content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 18, leading: 24, bottom: 18, trailing: 16)
        cell.contentConfiguration = content
        cell.backgroundColor = Theme.background
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(SongDetailViewController(store: store, songID: songs[indexPath.row].id), animated: true)
    }

    @objc private func addSong() {
        navigationController?.pushViewController(SongFormViewController(store: store), animated: true)
    }
}

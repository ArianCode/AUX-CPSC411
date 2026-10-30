import UIKit

final class HomeViewController: StackViewController {
    private let store: SongStore
    private let summary = Theme.label("", style: .headline)

    init(store: SongStore) { self.store = store; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { fatalError("Use init(store:)") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AUX"
        stack.addArrangedSubview(Theme.artwork())
        stack.addArrangedSubview(Theme.label("Your music. Your rankings.", style: .title1))
        stack.addArrangedSubview(Theme.label("Keep the songs you love in one place. Rate your listens and build a collection that sounds like you."))
        stack.addArrangedSubview(summary)
        stack.addArrangedSubview(Theme.button("My Rankings", id: "myRankings") { [weak self] in
            guard let self else { return }
            navigationController?.pushViewController(SongListViewController(store: store), animated: true)
        })
        stack.addArrangedSubview(Theme.button("Add a Song", id: "addSong") { [weak self] in
            guard let self else { return }
            navigationController?.pushViewController(SongFormViewController(store: store), animated: true)
        })
        stack.addArrangedSubview(Theme.label("A personal music journal", style: .footnote))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        summary.text = "\(store.ranked.count) songs in your collection"
    }
}

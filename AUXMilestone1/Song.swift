import Foundation

struct Song {
    let id: UUID
    var title: String
    var artist: String
    var album: String
    var rating: Double
    var notes: String

    init(id: UUID = UUID(), title: String, artist: String, album: String,
         rating: Double, notes: String = "") {
        self.id = id
        self.title = title
        self.artist = artist
        self.album = album
        self.rating = rating
        self.notes = notes
    }
}

/// Milestone 1 uses in-memory sample data; relaunching resets the collection.
final class SongStore {
    private var songs = [
        Song(title: "Ivy", artist: "Frank Ocean", album: "Blonde", rating: 9.4,
             notes: "A favorite for late-night listening. The guitar and vocals make this one stand out."),
        Song(title: "Nights", artist: "Frank Ocean", album: "Blonde", rating: 9.1),
        Song(title: "Redbone", artist: "Childish Gambino", album: "Awaken, My Love!", rating: 8.6),
        Song(title: "Self Control", artist: "Frank Ocean", album: "Blonde", rating: 8.2),
        Song(title: "Sicko Mode", artist: "Travis Scott", album: "Astroworld", rating: 7.8),
        Song(title: "Location", artist: "Khalid", album: "American Teen", rating: 7.1)
    ]

    var ranked: [Song] { songs.sorted { $0.rating > $1.rating } }
    func song(id: UUID) -> Song? { songs.first { $0.id == id } }
    func save(_ song: Song) {
        if let index = songs.firstIndex(where: { $0.id == song.id }) {
            songs[index] = song
        } else {
            songs.append(song)
        }
    }
}

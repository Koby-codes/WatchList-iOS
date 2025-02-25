import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String?
    let name: String? // For TV shows
    let poster_path: String?
}

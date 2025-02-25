import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String?
    let original_title: String?
    let tagline: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double?
    let vote_count: Int?
    let genres: [Genre]?
    let spoken_languages: [SpokenLanguage]
    let release_date: String?
    let runtime: Int?
    let production_companies: [ProductionCompany]?
    let production_countries: [ProductionCountry]?
    let revenue: Int?
    let budget: Int?
    let credits: Credits?
    let videos: Videos?
    let watchProviders: WatchProvidersResponse?

    // ✅ Fix: Use CodingKeys for correct JSON mapping
    enum CodingKeys: String, CodingKey {
        case id, title, tagline, overview, poster_path, backdrop_path, vote_average, vote_count, genres
        case spoken_languages, release_date, runtime, production_companies, production_countries
        case revenue, budget, credits, videos
        case original_title = "original_title"
        case watchProviders = "watch/providers" // TMDB uses this exact structure
    }
}

// ✅ Fix: Ensure Supporting Structs Conform to Decodable
struct Genre: Decodable {
    let id: Int
    let name: String
}

struct SpokenLanguage: Decodable {
    let english_name: String
}

struct ProductionCompany: Decodable {
    let name: String
}

struct ProductionCountry: Decodable {
    let name: String
}

struct Credits: Decodable {
    let cast: [Actor]
    let crew: [Crew]
}

struct Actor: Decodable, Identifiable {
    let id: Int
    let name: String
    let character: String?
    let profile_path: String?
}

struct Crew: Decodable, Identifiable {
    let id: Int
    let name: String
    let job: String
}

struct Videos: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let key: String
    let site: String
    let type: String
}

struct WatchProvidersResponse: Decodable {
    let results: [String: WatchProviderInfo]?
}

struct WatchProviderInfo: Decodable {
    let link: String?
    let flatrate: [StreamingPlatform]?
    let rent: [StreamingPlatform]?
    let buy: [StreamingPlatform]?
}

struct StreamingPlatform: Decodable, Identifiable {
    let provider_id: Int
    let provider_name: String
    let logo_path: String?

    var id: Int { provider_id }
}

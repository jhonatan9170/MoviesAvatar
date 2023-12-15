import Foundation

struct MovieDetailResponse: Codable {
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case overview, popularity,title
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}



struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"

    }
}

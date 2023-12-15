//
//  MovieListResponse.swift
//  MovieSoftek
//
//  Created by Jhonatan chavez chavez on 11/11/23.
//

import Foundation

// MARK: - MovieListResponse
struct MovieListResponse: Codable {
    let page: Int
    let results: [MovieResponse]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct MovieResponse: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}

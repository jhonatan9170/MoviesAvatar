//
//  MovieService.swift
//  MovieSoftek
//
//  Created by Jhonatan chavez chavez on 11/11/23.
//

import Foundation
protocol MoviesServiceProtocol {
    func getPopularMovies(page: Int,completion: @escaping (MovieListResponse?) -> Void )
    func getMovieDetail(id: Int,completion: @escaping (MovieDetailResponse?) -> Void )
    func getMoviesRelated(id: Int,completion: @escaping (MovieListResponse?) -> Void )

}

class MoviesService:MoviesServiceProtocol {
    
    var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func getPopularMovies(page: Int , completion: @escaping (MovieListResponse?) -> Void ) {
        let headers = [
            "Authorization": Constants.authorizacionKey
        ]
        let url = Constants.getMoviesByPageURL + String(page)
        apiClient.request(url: url, method: .get, headers: headers, parameters: nil){(result : Result<MovieListResponse, APIClientError>) in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getMovieDetail(id: Int , completion: @escaping (MovieDetailResponse?) -> Void ) {
        let headers = [
            "Authorization": Constants.authorizacionKey
        ]
        let url = Constants.baseURL + "/" + String(id)
        apiClient.request(url: url, method: .get, headers: headers, parameters: nil){(result : Result<MovieDetailResponse, APIClientError>) in
            switch result {
            case .success(let movie):
                completion(movie)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getMoviesRelated(id: Int , completion: @escaping (MovieListResponse?) -> Void ) {
        let headers = [
            "Authorization": Constants.authorizacionKey
        ]
        let url = Constants.baseURL + "/" + String(id)  + "/recommendations"
        apiClient.request(url: url, method: .get, headers: headers, parameters: nil){(result : Result<MovieListResponse, APIClientError>) in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(_):
                completion(nil)
            }
        }
    }
}

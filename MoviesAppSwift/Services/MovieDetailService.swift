//
//  MovieDetailService.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import Foundation

protocol MovieDetailServiceProtocol {
    func detailForMovie(_ movieId: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void)
}

class MovieDetailService: MovieDetailServiceProtocol {
    
    let apiManager: ApiManagerProtocol
    
    init(_ apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func detailForMovie(_ movieId: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        apiManager.fetchData(endpoint: MoviesEndpoint.movieDetail(movieId: movieId), responseModel: Movie.self) { result in
            switch result {
            case .success(let response):
                completionHandler(.success(response))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}


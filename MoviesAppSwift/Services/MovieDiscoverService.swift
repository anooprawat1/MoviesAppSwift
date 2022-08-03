//
//  MovieService.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import Foundation

protocol MovieDiscoverServiceProtocol {
    func discoverMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieDiscoverService: MovieDiscoverServiceProtocol {
    
    let apiManager: ApiManagerProtocol
    
    init(_ apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func discoverMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        apiManager.fetchData(endpoint: MoviesEndpoint.discover, responseModel: MovieResponse.self) { result in
            switch result {
            case .success(let response):
                completionHandler(.success(response.results))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

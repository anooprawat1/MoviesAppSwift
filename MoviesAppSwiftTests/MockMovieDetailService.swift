//
//  MockMovieDetailService.swift
//  MoviesAppSwiftTests
//
//  Created by Anoop on 06.08.22.
//

import Foundation
@testable import MoviesAppSwift

class MockMovieDetailServiceSuccess: MovieDetailServiceProtocol {
    
    
    init() {}
    
    func detailForMovie(_ movieId: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        completionHandler(.success(movie()))
    }
    
    func movie() -> Movie {
        
        let dateString = "2022-01-01"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)

        let movie1 = Movie(id: 1, isAdult: false, title: "Movie Title 1", overview: "Movie Overview 1", popularity: 4.0, releaseDate: date, imagePath: "/imagepath1", voteAverage: 9.0, voteCount: 10, backdropPath: "/imageBackdropPath1")
        
        return movie1
    }
}


class MockMovieDetailServiceFailure: MovieDetailServiceProtocol {
    
    init() {}
    
    func detailForMovie(_ movieId: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        completionHandler(.failure(NSError(domain: "Error", code: 1005)))
    }

}

//
//  MockMovieDiscoverService.swift
//  MoviesAppSwiftTests
//
//  Created by Anoop on 05.08.22.
//

import Foundation
@testable import MoviesAppSwift

class MockMovieDiscoverServiceSuccess: MovieDiscoverServiceProtocol {
    
    init() {}
    
    func discoverMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        completionHandler(.success(movies()))
    }
    
    func movies() -> [Movie] {
        
        let dateString = "2022-01-01"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        let dateString2 = "2022-01-02"
        let date2 = dateFormatter.date(from: dateString2)

        let movie1 = Movie(id: 1, isAdult: false, title: "Movie Title 1", overview: "Movie Overview 1", popularity: 4.0, releaseDate: date, imagePath: "/imagepath1", voteAverage: 9.0, voteCount: 10, backdropPath: "/imageBackdropPath1")
        
        let movie2 = Movie(id: 1, isAdult: false, title: "Movie Title 2", overview: "Movie Overview 2", popularity: 4.0, releaseDate: date2, imagePath: "/imagepath2", voteAverage: 9.0, voteCount: 10, backdropPath: "/imageBackdropPath2")
        return [movie1, movie2]
    }
}


class MockMovieDiscoverServiceFailure: MovieDiscoverServiceProtocol {
    
    init() {}
    
    func discoverMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        completionHandler(.failure(NSError(domain: "Error", code: 1005)))
    }

}

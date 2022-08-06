//
//  MovieDetailListViewModelTests.swift
//  MoviesAppSwiftTests
//
//  Created by Anoop on 06.08.22.
//

import XCTest
@testable import MoviesAppSwift

class MovieDetailListViewModelTests: XCTestCase {

    func testMovieListViewModelIntialization() {
        let movieDetailProtocol: MovieDetailServiceProtocol = MockMovieDetailServiceSuccess()
        let movieDetailViewModel = MovieDetailViewModel(movieDetailProtocol, movie: selectedMovie())
        movieDetailViewModel.fetchMovieDetail()
        XCTAssertEqual(movieDetailViewModel.movieDetail.id, 1)

        XCTAssertEqual(movieDetailViewModel.movieDetail.title, "Movie Title 1")
        XCTAssertEqual(movieDetailViewModel.movieDetail.description, "Movie Overview 1")

        XCTAssertEqual(movieDetailViewModel.imagePath.value, "/imageBackdropPath1")
        XCTAssertEqual(movieDetailViewModel.movieDetail.releaseDate, "Release Date - Jan 1, 2022")
    }
    
    func testMovieListViewModelWithFailureService() {
        let movieDetailProtocol: MovieDetailServiceProtocol = MockMovieDetailServiceFailure()
        let movieDetailViewModel = MovieDetailViewModel(movieDetailProtocol, movie: selectedMovie())
        movieDetailViewModel.fetchMovieDetail()
        XCTAssertEqual(movieDetailViewModel.movieDetail.id, 1)
        XCTAssertEqual(movieDetailViewModel.imagePath.value, nil)
    }
    
    func selectedMovie() -> Movie {
        let dateString = "2022-01-01"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)

        let movie1 = Movie(id: 1, isAdult: false, title: "Movie Title 1", overview: "Movie Overview 1", popularity: 4.0, releaseDate: date, imagePath: "/imagepath1", voteAverage: 9.0, voteCount: 10, backdropPath: "/imageBackdropPath1")
        
        return movie1
    }
}

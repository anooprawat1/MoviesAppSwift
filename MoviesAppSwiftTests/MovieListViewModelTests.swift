//
//  MovieListViewModelTests.swift
//  MoviesAppSwiftTests
//
//  Created by Anoop on 05.08.22.
//

import XCTest
@testable import MoviesAppSwift

class MovieListViewModelTests: XCTestCase {
    
    func testMovieListViewModelIntialization() {
        let movieDiscoverService: MovieDiscoverServiceProtocol = MockMovieDiscoverServiceSuccess()
        let movieListViewModel = MovieListViewModel(movieDiscoverService) { _ in }
        movieListViewModel.fetchMovies()
        XCTAssertEqual(movieListViewModel.listItems.value.count, 2)
        XCTAssertEqual(movieListViewModel.listItems.value[0].title, "Movie Title 1")
        XCTAssertEqual(movieListViewModel.listItems.value[0].imagePath, "/imagepath1")
        XCTAssertEqual(movieListViewModel.listItems.value[0].releaseDate, "Release Date - Jan 1, 2022")

        XCTAssertEqual(movieListViewModel.listItems.value[1].title, "Movie Title 2")
        XCTAssertEqual(movieListViewModel.listItems.value[1].imagePath, "/imagepath2")
        XCTAssertEqual(movieListViewModel.listItems.value[1].releaseDate, "Release Date - Jan 2, 2022")
    }
    
    func testMovieListViewModelWithFailureService() {
        let movieDiscoverService: MovieDiscoverServiceProtocol = MockMovieDiscoverServiceFailure()
        let movieListViewModel = MovieListViewModel(movieDiscoverService) { _ in }
        movieListViewModel.fetchMovies()
        XCTAssertEqual(movieListViewModel.listItems.value.count, 0)
    }
    
    func testMovieListViewModel() {
        let exp = expectation(description: "Movies did select")
        var selectedMovie: Movie!
        let movieDiscoverService: MovieDiscoverServiceProtocol = MockMovieDiscoverServiceSuccess()
        let movieListViewModel = MovieListViewModel(movieDiscoverService) { movie in
            selectedMovie = movie
            exp.fulfill()
        }
        movieListViewModel.fetchMovies()
        XCTAssertEqual(movieListViewModel.listItems.value.count, 2)
        XCTAssertEqual(movieListViewModel.listItems.value[0].title, "Movie Title 1")
        XCTAssertEqual(movieListViewModel.listItems.value[1].title, "Movie Title 2")
        movieListViewModel.didSelectRow(0)
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(selectedMovie.title, "Movie Title 1")
    }

}

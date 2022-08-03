//
//  ViewModel.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import Foundation

class MovieListViewModel {
    
    private let movieDiscoverService: MovieDiscoverServiceProtocol
    let listItems: Observable<[MoviesListItemViewModel]> = Observable([])
    private var movies = [Movie]()
    private let listSelectionHandler: (Movie) -> Void
    
    init(_ movieDiscoverService: MovieDiscoverServiceProtocol, listSelectionHandler: @escaping (Movie) -> Void) {
        self.movieDiscoverService = movieDiscoverService
        self.listSelectionHandler = listSelectionHandler
    }
    
    func fetchMovies() {
        self.movieDiscoverService.discoverMovies {[weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.listItems.value = movies.map(MoviesListItemViewModel.init)
            case .failure(_):
                break
            }
        }
    }
    
    func didSelectRow(_ selectedRow: Int) {
        listSelectionHandler(movies[selectedRow])
    }
}

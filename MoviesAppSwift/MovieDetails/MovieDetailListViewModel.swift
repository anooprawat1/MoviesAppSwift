//
//  MovieDetailListViewModel.swift
//  MoviesAppSwift
//
//  Created by Anoop on 02.08.22.
//

import Foundation

class MovieDetailViewModel {
    private let movieDetailsService: MovieDetailServiceProtocol
    private (set) var movieDetail: MovieDetailModel
    private (set) var imagePath: Observable<String?> = Observable(nil)
    
    
    init(_ movieDetailsService: MovieDetailServiceProtocol, movie: Movie) {
        self.movieDetailsService = movieDetailsService
        self.movieDetail = MovieDetailModel(movie)
    }
    
    func fetchMovieDetail() {
        self.movieDetailsService.detailForMovie(movieDetail.id) {[weak self] result in
            switch result {
            case .success(let movie):
                self?.movieDetail = MovieDetailModel(movie)
                self?.imagePath.value = movie.backdropPath
            case .failure(_):
                break
            }
        }
    }
}

struct MovieDetailModel {
    var id: Int
    var title: String?
    var releaseDate: String?
    var description: String?
    
    init(_ movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        if let date = movie.releaseDate {
            self.releaseDate = "Release Date - \(Formatter.dateFormatter.string(from: date))"
        } else {
            self.releaseDate = nil
        }
        self.description = movie.overview
    }
}

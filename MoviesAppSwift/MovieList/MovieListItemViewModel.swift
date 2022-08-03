//
//  MovieListItemViewModel.swift
//  MoviesAppSwift
//
//  Created by Anoop on 02.08.22.
//

import Foundation

struct MoviesListItemViewModel: Equatable {
    let title: String?
    let releaseDate: String?
    let imagePath: String?
}

extension MoviesListItemViewModel {

    init(_ movie: Movie) {
        self.title = movie.title
        self.imagePath = movie.imagePath
        if let date = movie.releaseDate {
            self.releaseDate = "Release Date - \(Formatter.dateFormatter.string(from: date))"
        } else {
            self.releaseDate = nil
        }
    }
}

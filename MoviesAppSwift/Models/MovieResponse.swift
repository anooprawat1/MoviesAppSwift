//
//  MovieResponse.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let isAdult: Bool?
    let title: String
    let overview: String
    let popularity: Float
    let releaseDate: Date?
    let imagePath: String?
    let voteAverage: Float?
    let voteCount: Int?
    let backdropPath: String?
    
    private enum CodingKeys: String, CodingKey {
            case id
            case isAdult = "adult"
            case title
            case overview
            case popularity
            case releaseDate = "release_date"
            case imagePath = "poster_path"
            case voteAverage
            case voteCount
            case backdropPath = "backdrop_path"
    }
}

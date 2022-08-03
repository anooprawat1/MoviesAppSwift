//
//  Configuration.swift
//  MoviesAppSwift
//
//  Created by Anoop on 02.08.22.
//

import Foundation

final class Configuration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("Missing Api key")
        }
        return apiKey
    }()
    
    lazy var scheme: String = {
        return "https"
    }()
    
    lazy var host: String = {
        return "api.themoviedb.org"
    }()
    
    lazy var imageBaseUrl: String = {
        return "https://image.tmdb.org/t/p/original"
    }()
    
}

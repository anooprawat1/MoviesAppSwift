//
//  DependencyContainer.swift
//  MoviesAppSwift
//
//  Created by Anoop on 02.08.22.
//

import Foundation

final class DependencyContainer {
    lazy var configuration = Configuration()
    
    lazy var apiClient: ApiManagerProtocol = {
        let apiConfiguration = ApiConfiguration(scheme: configuration.scheme, host: configuration.host, apiKey: configuration.apiKey)
        var manager = ApiManager(apiConfiguration)
        return manager
    }()
    
    lazy var imageLoader: ImageDownloader = {
        let imageLoader = ImageDownloader(configuration.imageBaseUrl)
        return imageLoader
    }()
}

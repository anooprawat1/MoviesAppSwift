//
//  AppCoordinator.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import Foundation
import UIKit

class AppCoordinator {
    private let navigationController: UINavigationController
    private let dependencyContainer: DependencyContainer
    init(navigationController: UINavigationController, dependencyContainer: DependencyContainer) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(identifier: "ViewController") { [weak self] coder in
            guard let self = self else {
                return nil
            }
            let apiManager = self.dependencyContainer.apiClient
            let movieDiscoverService = MovieDiscoverService(apiManager)
            let viewModel = MovieListViewModel(movieDiscoverService, listSelectionHandler: self.showMovieDetail)
            let viewController = MovieListViewController(coder: coder, viewModel: viewModel, imageLoader: self.dependencyContainer.imageLoader)
            return viewController
        }
        navigationController.pushViewController(initialViewController, animated: false)
    }
}


extension AppCoordinator {
    
    func showMovieDetail(_ movie: Movie) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let productDetailViewController = storyboard.instantiateViewController(identifier: "MovieDetailListViewController") { [weak self] coder in
            guard let self = self else {
                return nil
            }
            let movieDetailService = MovieDetailService(self.dependencyContainer.apiClient)
            let movieDetailViemModel = MovieDetailViewModel(movieDetailService, movie: movie)
            let movieDetailViewController = MovieDetailListViewController(coder: coder, viewModel: movieDetailViemModel, imageLoader: self.dependencyContainer.imageLoader)
            return movieDetailViewController
        }
        navigationController.pushViewController(productDetailViewController, animated: true)
    }
    
}

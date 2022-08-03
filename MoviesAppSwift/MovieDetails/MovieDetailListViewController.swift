//
//  MovieDetailListViewController.swift
//  MoviesAppSwift
//
//  Created by Anoop on 02.08.22.
//

import UIKit

class MovieDetailListViewController: UIViewController {

    @IBOutlet var moviewImageView: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieReleaseDate: UILabel!
    @IBOutlet var movieDescription: UITextView!
    let viewModel: MovieDetailViewModel!
    let imageLoader: ImageDownloader

    init?(coder: NSCoder, viewModel: MovieDetailViewModel, imageLoader: ImageDownloader) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
        super.init(coder: coder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Viewcontroller must have a ViewModel")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.imagePath.observe(on: self) { [weak self] imagePath in
            self?.setupImage(imagePath)
        }
        viewModel.fetchMovieDetail()
    }
    
    func setupViews() {
        movieTitle.text = viewModel.movieDetail.title
        movieReleaseDate.text = viewModel.movieDetail.releaseDate
        movieDescription.text = viewModel.movieDetail.description
    }
    
    func setupImage(_ imagePath: String?) {
        self.imageLoader.downloadImage(with: imagePath, completionHandler: {[weak self] image, _ in
            self?.moviewImageView.image = image
        })
    }
    
}

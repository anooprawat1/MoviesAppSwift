//
//  MovieTableViewCell.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!
    
    override func prepareForReuse() {
        movieImageView.image = nil
    }
    
    func setUpViewWith(_ itemListViewModel: MoviesListItemViewModel, imageLoader: ImageDownloader) {
        self.name.text = itemListViewModel.title
        self.date.text = itemListViewModel.releaseDate
        imageLoader.downloadImage(with: itemListViewModel.imagePath, completionHandler: { [weak self] image, _ in
            guard let self = self else {
                return
            }
            self.movieImageView.image = image
        })
    }
    
}

//
//  ViewController.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let viewModel: MovieListViewModel!
    let imageLoader: ImageDownloader
    weak var coordinatorDelegate: MovieListCoordinatorProtocol?

    init?(coder: NSCoder, viewModel: MovieListViewModel, imageLoader: ImageDownloader) {
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
        self.title = "Movies"
        setUpViewModel()
        setUpTableView()
    }

    func setUpViewModel() {
        viewModel.listItems.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
        viewModel.fetchMovies()
    }

    func setUpTableView() {
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listItems.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let movieItemListViewModel = viewModel.listItems.value[indexPath.row]
        cell.setUpViewWith(movieItemListViewModel, imageLoader: self.imageLoader)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row)
    }
    
}

protocol MovieListCoordinatorProtocol: AnyObject {
    func showMovieDetail(_ movie: Movie)
}

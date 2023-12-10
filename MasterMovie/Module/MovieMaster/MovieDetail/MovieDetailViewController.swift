//
//  MovieDetailViewController.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//


import UIKit
import Combine

class MovieDetailViewController: BaseViewController {
    // MARK: - Properties
    private var subscribers: Set<AnyCancellable> = []
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: MovieDetailViewModel!
    var coordinator: MovieDetailCoordinator!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Bind views to the ViewModel
        bindViews()
    }
}
// MARK: - Private Functions
extension MovieDetailViewController {
    
    // Bind UI elements to ViewModel properties
    private func bindViews() {
        viewModel.$movieImage.sink { [weak self] image in
            if let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
                Task {
                    self?.movieImageView?.image = await UIImage.load(url: url)
                }
            }
        }.store(in: &subscribers)
        viewModel.$movieDescription.sink { [weak self] desc in
            self?.descriptionLabel.text = desc
        }.store(in: &subscribers)
        viewModel.$movieTitle.sink { [weak self] title in
            self?.nameLabel.text = title
        }.store(in: &subscribers)
    }
}

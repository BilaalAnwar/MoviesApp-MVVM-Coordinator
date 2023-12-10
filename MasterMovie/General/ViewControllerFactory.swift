//
//  ViewControllerFactory.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation
import UIKit

// Protocol defining the requirements for a view controller factory
protocol ViewControllerFactoryProtocol {
    init(apiClient: APIClientProtocol)
    func allMoviesListViewController(navigationController: UINavigationController) -> AllMoviesListViewController
}

// Implementation of the view controller factory
class ViewControllerFactory: ViewControllerFactoryProtocol {
    private let apiClient: APIClientProtocol
    required init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    func allMoviesListViewController(navigationController: UINavigationController) -> AllMoviesListViewController {
        let viewController = Storyboard.movieMaster.instantiateViewController(identifier: AllMoviesListViewController.storyboardIdentifier) as! AllMoviesListViewController
        let movieService = MovieService(apiClient: apiClient)
        viewController.viewModel = AllMoviesListViewModel(service: movieService)
        viewController.coordinator = AllMoviesListCoordinator(navigationController: navigationController, viewControllerFactory: self)
        
        return viewController
    }

}


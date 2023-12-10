//
//  AllMoviesListCoordinator.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import UIKit

class AllMoviesListCoordinator {
    
    let viewControllerFactory: ViewControllerFactory
    let navigationController: UINavigationController
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
}



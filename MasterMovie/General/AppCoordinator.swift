//
//  AppCoordinator.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import UIKit

// Coordinator responsible for managing the app's navigation and view controllers
class AppCoordinator {
    
    // MARK: - Properties
    
    let window: UIWindow
    let viewControllerFactory: ViewControllerFactoryProtocol
    let navigationController: UINavigationController
    let homeNavigationController: UINavigationController
    
    // MARK: - Initializer
    
    init(window: UIWindow, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.window = window
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = UINavigationController()
        self.homeNavigationController = UINavigationController()
        setupNavigationBarUI()
    }
}

// MARK: - Private Functions
extension AppCoordinator {
    
    // Function to set up the global appearance of the navigation bar
    fileprivate func setupNavigationBarUI() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.blue
        ]
        let backButtonInsets = UIEdgeInsets(top: 0, left: 12, bottom: 3, right: 0)
        let backImage = UIImage(systemName: "arrow.backward")
        navigationBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        let titleOffset = UIOffset(horizontal: -CGFloat.greatestFiniteMagnitude, vertical: 0)
        navigationBarAppearance.titlePositionAdjustment = titleOffset
        navigationBarAppearance.backgroundColor = .systemPink
        UINavigationBar.appearance().tintColor = .yellow
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    // Function to set up the initial view controller and navigation
     func startViewController() {
        // Create the initial view controller (AllMoviesListViewController)
        let viewController = viewControllerFactory.allMoviesListViewController(navigationController: navigationController)
        // Push the initial view controller onto the navigation stack
        navigationController.pushViewController(viewController, animated: false)
        // Set the navigation controller as the root view controller for the window
        window.rootViewController = navigationController
        // Make the window visible
        window.makeKeyAndVisible()
    }
}


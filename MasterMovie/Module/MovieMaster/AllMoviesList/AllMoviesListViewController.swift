//
//  AllMoviesListViewController.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import UIKit
import Combine

class AllMoviesListViewController: UIViewController {
    
    private var subscribers: Set<AnyCancellable> = []
    
    var viewModel: AllMoviesListViewModel!
    var coordinator: AllMoviesListCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

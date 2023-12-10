//
//  AllMoviesListViewController.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import UIKit
import Combine

// View controller for displaying a list of movies
class AllMoviesListViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var subscribers: Set<AnyCancellable> = []
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            // Set up target-action for handling search query changes
            searchTextField.addTarget(self, action: #selector(onSearchQueryChange(_:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            // Set up the table view and its delegate
            delegate = TableViewDelegate(tableView: tableView)
            tableView.dataSource = delegate
            tableView.delegate = delegate
        }
    }
    
    var delegate: TableViewDelegate!
    var viewModel: AllMoviesListViewModel!
    var coordinator: AllMoviesListCoordinator!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Bind views to the ViewModel
        bindViews()
        // Fetch the list of movies
        getMoviesList()
    }
}

// MARK: - Private Functions
extension AllMoviesListViewController {
    
    // Bind UI elements to ViewModel properties
    private func bindViews() {
        viewModel.$progressing.receive(on: RunLoop.main).sink { [weak self] progressing in
            progressing ? self?.showProgress() : self?.hideProgress()
        }.store(in: &subscribers)
    }
    
    // Fetch the list of movies using the ViewModel
    fileprivate func getMoviesList() {
        Task { [weak self] in
            do {
                try await self?.viewModel.updateHomeShortcuts()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITextField Action
extension AllMoviesListViewController {
    
    // Handle changes in the search query
    @objc private func onSearchQueryChange(_ textField: UITextField) {
        // Set up the table view with the filtered list based on the search query
        setUpCategoriesTableView(with: textField.text)
    }
    
    // Set up the table view with the filtered list based on the search query
    private func setUpCategoriesTableView(with searchQuery: String? = nil) {
        
    }
}


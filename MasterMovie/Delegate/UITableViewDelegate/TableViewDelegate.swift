//
//  TableViewDelegate.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation
import UIKit

// Class responsible for managing UITableViewDataSource and UITableViewDelegate for a UITableView
class TableViewDelegate: NSObject, UITableViewDataSource {
    
    var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    // Array of cell models that will be displayed in the table view
    var cellModels: [any TableCellModel] = [] {
        didSet {
            cellModels.forEach { model in
                tableView.register(UINib(nibName: model.identifier, bundle: nil), forCellReuseIdentifier: model.identifier)
            }
        }
    }
    // Return the number of cell models to determine the number of rows in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    // Dequeue a reusable cell and update its content using the corresponding cell model
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath)
        let cellUpdating = cell as! CellUpdating
        cellUpdating.update(cellModel.data)
        cell.selectionStyle = .none
        return cell
    }
}

extension TableViewDelegate: UITableViewDelegate {
    // Deselect the row and invoke the didSelect closure if provided in the cell model
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = cellModels[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        cellModel.didSelect?(cellModel.data)
    }
    // Return the height for a specific row in the table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellModels[indexPath.row].height
    }
}

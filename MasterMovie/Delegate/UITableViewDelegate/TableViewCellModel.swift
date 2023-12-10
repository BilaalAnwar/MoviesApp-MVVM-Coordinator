//
//  TableViewCellModel.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

protocol TableCellModel {
    var identifier: String { get }
    var height: CGFloat { get }
    var data: CellData { get }
    var didSelect: ((CellData) -> Void)? { get }
}

protocol CellData {
    
}

protocol CellUpdating {
    func update(_ data: CellData)
}


//
//  MovieDetailCellModel.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

struct MovieDetailCellModel: TableCellModel {
    var identifier = "MoveDetailTableViewCell"
    var height: CGFloat = 120
    var data: CellData
    var didSelect: ((CellData) -> Void)?
}

extension MovieItemResponse: CellData {

}

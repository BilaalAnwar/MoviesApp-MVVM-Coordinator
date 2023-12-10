//
//  MoveDetailTableViewCell.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import UIKit

class MoveDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var movieDetail: AllMovieResponse!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MoveDetailTableViewCell: CellUpdating {
    func update(_ data: CellData) {
        movieDetail = data as? AllMovieResponse
        self.titleLabel?.text = movieDetail.title
        
        if let urlString = movieDetail.image?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            Task {
                self.iconImageView?.image = await UIImage.load(url: url)
            }
        }
    }
}

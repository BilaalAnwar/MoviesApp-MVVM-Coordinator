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
    var movieDetail: MovieItemResponse!
    
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
        movieDetail = data as? MovieItemResponse
        self.titleLabel?.text = movieDetail.original_title
        self.descriptionLabel?.text = movieDetail.overview
        let imageUrl : String = "https://image.tmdb.org/t/p/w500\(movieDetail.backdrop_path ?? "")"
        if let urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            Task {
                self.iconImageView?.image = await UIImage.load(url: url)
            }
        }
    }
}

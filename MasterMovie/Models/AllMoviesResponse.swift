//
//  AllMoviesResponse.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

struct AllMovieResponse : Codable {
    let responseCode : String?
    let responseDescription : String?
    let title : String?
    let image : String?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case description = "description"
        case responseCode = "responseCode"
        case responseDescription = "responseDescription"
    }
}

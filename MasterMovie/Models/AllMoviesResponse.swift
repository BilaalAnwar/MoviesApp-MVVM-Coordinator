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
    
    enum CodingKeys: String, CodingKey {
        
        case responseCode = "responseCode"
        case responseDescription = "responseDescription"
    }
}

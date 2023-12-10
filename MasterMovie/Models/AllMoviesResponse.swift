//
//  AllMoviesResponse.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

struct AllMovieResponse : Codable {
    let page, total_pages, total_results : Int?
    let results : [MovieItemResponse]?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }
}

struct MovieItemResponse : Codable {
    let backdrop_path : String?
    let id : Int?
    let original_language : String?
    let original_title : String?
    let overview : String?
    
    enum CodingKeys: String, CodingKey {
        case backdrop_path = "backdrop_path"
        case id = "id"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
    }
}

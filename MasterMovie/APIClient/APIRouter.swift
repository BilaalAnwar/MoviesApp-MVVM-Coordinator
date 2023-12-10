//
//  APIRouter.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
}


enum APIRouter {
    case allMovies(mobileNo: String)
    case movieDetail(mobileNo: String)
    
    var method: HTTPMethod {
        return .get
    }
    //Endpoint for each API call
    var path: String {
        switch self {
        case .allMovies:
            return "movie/popular"
        case .movieDetail:
            return "movie/popular"
        }
    }
    
    // Parameters for each API call
    var parameters: [String: String] {
        return [:]
    }
    // Headers for each API call
    var headers: [String: String] {
        // Common headers
        let header: [String: String] = [
            "accept": "application/json",
            "api_key": Constants.movieApiKey
        ]
        return header
    }
    var body: [String: Any] {
        var body: [String: Any]
        switch self {
        case .allMovies(mobileNo: let mobileNo):
            body = ["mobileNo": mobileNo]
        case .movieDetail(mobileNo: let mobileNo):
            body = ["mobileNo": mobileNo]
        }
        return body
    }
    var baseURL: String {
        return Constants.apiBaseURL
    }
}


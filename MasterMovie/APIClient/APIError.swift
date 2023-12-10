//
//  APIError.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

enum APIError: LocalizedError {
    case jsonParsing
    case notFound
    case internlServerError
    case unexpectedError
    case unauthorized
    case other(String)
    public var errorDescription: String? {
        switch self {
        case .jsonParsing:
            return "Invalid response. Please try again later."
        case .notFound:
            return "Not found"
        case .internlServerError, .unexpectedError:
            return "We are unable to process your request at this time. Please try again later."
        case .unauthorized:
            return "Your session has expired, please Login and Continue."
        case .other(let message):
            return message
        }
    }
}

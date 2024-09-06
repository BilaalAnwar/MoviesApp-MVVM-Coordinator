//
//  MockAPIClient.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 9/6/24.
//

import Foundation

struct MockAPIClient: APIClientProtocol {
    let urlSession: URLSessionProtocol
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func sendRequest<T>(_ router: APIRouter) async throws -> APIResponse<T> where T : Decodable {
        do {
            let request = self.makeURLRequest(router: router)
            let httpStatusCode = getHttpStatusCode(router: router)
            guard let request else {
                throw APIError.other("Bad request")
            }
            let (data, _) = try await urlSession.data(for: request)
            print(String(data: data, encoding: .utf8)!)
            let result = try? JSONDecoder().decode(T.self, from: data)
            guard let result else {
                throw APIError.jsonParsing
            }
            return APIResponse(httpStatusCode: httpStatusCode, result: result)
        } catch {
            throw APIError.other(error.localizedDescription)
        }
    }
}

// MARK: - Private Functions
extension MockAPIClient {
    private func makeURLRequest(router: APIRouter) -> URLRequest? {
        switch router {
        case .allMovies:
            let url = Bundle.main.url(forResource: "MovieDetailsResponse", withExtension: "json")
            return URLRequest(url: url!)
        }
    }
    
    private func getHttpStatusCode(router: APIRouter) -> Int {
        switch router {
        default:
            return 200
        }
    }
}

//
//  MovieMasterService.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

protocol MovieServiceProtocol {
    func getAllMoviesData() async throws ->  [MovieItemResponse]
}

class MovieService : MovieServiceProtocol {
    let apiClient: APIClientProtocol
    required init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    func getAllMoviesData() async throws ->  [MovieItemResponse] {
        let apiRouter = APIRouter.allMovies
        let response: APIResponse<AllMovieResponse> = try await apiClient.sendRequest(apiRouter)
        let responseResult = response.result
        if let moviesList = responseResult.results {
            return moviesList

      }
        throw APIError.other("Something went wrong")
    }
}

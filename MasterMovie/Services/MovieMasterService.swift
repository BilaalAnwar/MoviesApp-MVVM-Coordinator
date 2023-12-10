//
//  MovieMasterService.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

protocol MovieServiceProtocol {
    func getAllMoviesData() async throws ->  AllMovieResponse
}

class MovieService : MovieServiceProtocol {
    let apiClient: APIClientProtocol
    required init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    func getAllMoviesData() async throws ->  AllMovieResponse {
        let apiRouter = APIRouter.allMovies(mobileNo: "")
        let response: APIResponse<AllMovieResponse> = try await apiClient.sendRequest(apiRouter)
        let responseResult = response.result
        if responseResult.responseCode == "200" {
            return responseResult
        }
        throw APIError.other(responseResult.responseDescription ?? "")
    }
}

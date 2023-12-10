//
//  AllMoviesListViewModel.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

// ViewModel responsible for managing the data and business logic for displaying a list of movies
class AllMoviesListViewModel {
    @Published var progressing: Bool = false
    @Published var allMovies: [MovieItemResponse] = []
    let service: MovieServiceProtocol
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    // Fetch the list of all movies asynchronously
    func allMovieList() async throws -> Void {
        do {
            progressing = true
            allMovies = try await service.getAllMoviesData()
            progressing = false
        } catch {
            progressing = false
            throw error
        }
    }
}


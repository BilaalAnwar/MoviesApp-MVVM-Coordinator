//
//  AllMoviesListViewModel.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

class AllMoviesListViewModel {
    @Published var progressing: Bool = false
    let service: MovieServiceProtocol
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    func updateHomeShortcuts() async throws -> Void {
        do {
            progressing = true
            let _ = try await service.getAllMoviesData()
            progressing = false
        } catch {
            progressing = false
            throw error
        }
    }
}


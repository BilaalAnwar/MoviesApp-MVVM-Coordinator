//
//  MovieDetailViewModel.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation

class MovieDetailViewModel {
    @Published var movie: MovieItemResponse? {
        didSet {
            movieTitle = movie?.original_title ?? ""
            movieDescription = movie?.overview ?? ""
            movieImage = "https://image.tmdb.org/t/p/w500\(movie?.backdrop_path ?? "")"
        }
    }
    @Published var movieImage : String = ""
    @Published var movieDescription : String = ""
    @Published var movieTitle : String = ""
    init(movie: MovieItemResponse) {
        self.movie = movie
    }
}

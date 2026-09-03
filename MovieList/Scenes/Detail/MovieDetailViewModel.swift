//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Walter Junior on 03/09/26.
//

import Foundation


@Observable
final class MovieDetailViewModel {
    
    let movie: MovieModel
    
    init(movie: MovieModel) {
        self.movie = movie
    }
}

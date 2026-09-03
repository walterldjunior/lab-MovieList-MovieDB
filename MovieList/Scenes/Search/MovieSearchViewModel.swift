//
//  MovieSearchViewModel.swift
//  MovieList
//
//  Created by Walter Junior on 03/09/26.
//

import Foundation

@Observable
final class MovieSearchViewModel {
    
    private(set) var movies: [MovieModel] = []
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func search(text: String) {
        Task {
            do {
                let response: PopularMoviesResponse = try await networkManager.request(.search(query: text, page: 1))
                self.movies = response.results
            } catch let error {
                print("Ocorreu um erro na busca: \(error)")
            }
        }
    }
}

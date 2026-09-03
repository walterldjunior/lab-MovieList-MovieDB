//
//  MainListViewModel.swift
//  MovieList
//
//  Created by Walter Junior on 01/06/26.
//

import Foundation

protocol MainListViewModelProtocol: AnyObject {
    func loadData() async throws -> [MovieModel]
}

final class MainListViewModel: MainListViewModelProtocol {
    
    // MARK: - Public methods
    
    func loadData() async throws -> [MovieModel] {
        return try await requestPopularMovies()
    }
    
    func requestPopularMovies() async throws -> [MovieModel] {
        let response: PopularMoviesResponse = try await NetworkManager().request(.popular(page: 1))
        return response.results
    }
}

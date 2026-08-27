//
//  MainListViewModel.swift
//  MovieList
//
//  Created by Walter Junior on 01/06/26.
//

import Foundation

protocol MainListViewModelProtocol: AnyObject {
    func loadData() async throws -> [MoviesModel]
}

final class MainListViewModel: MainListViewModelProtocol {
    
    // MARK: - Public methods
    
    func loadData() async throws -> [MoviesModel] {
        return try await requestPopularMovies()
    }
}

extension MainListViewModel {
    func requestPopularMovies() async throws -> [MoviesModel] {
        let response: PopularMoviesResponse = try await NetworkManager().request(.popular(page: 1))
        return response.results
    }
}

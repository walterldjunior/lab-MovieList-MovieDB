//
//  MainListViewModel.swift
//  MovieList
//
//  Created by Walter Junior on 01/06/26.
//

import Foundation

protocol MainListViewModelDelegate: AnyObject {
    func displayData(value: [MoviesModel])
}

final class MainListViewModel: MainListViewModelProtocol {
    weak var delegate: MainListViewModelDelegate?
    
    // MARK: - Public methods
    
    func loadData() {
        Task {
            do {
                let movies: [MoviesModel] = try await requestPopularMovies()
                self.delegate?.displayData(value: movies)
            } catch {
                // TODO: Tratar erro.
            }
        }
    }
}

extension MainListViewModel {
    func requestPopularMovies() async throws -> [MoviesModel] {
        let response: PopularMoviesResponse = try await NetworkManager().request(.popular(page: 1))
        return response.results
    }
}

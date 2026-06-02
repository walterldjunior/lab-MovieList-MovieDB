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

protocol MainListViewModelProtocol: AnyObject{
    var delegate: MainListViewModelDelegate? { get set }
    func loadData()
}

final class MainListViewModel: MainListViewModelProtocol {
    weak var delegate: MainListViewModelDelegate?
    
    func loadData() {
        requestPopularMovies()
    }
}

extension MainListViewModel {
    func requestPopularMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")!
        
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMWU5MjdkYmE4N2ZiZDljOTFmN2JmYjQ1ZmFmMDk3OCIsIm5iZiI6MTc4MDMzMTUwMC45ODU5OTk4LCJzdWIiOiI2YTFkYjNlYzg1ZjQ5YWRhMzBjYWI4OTciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.srDTDFaoYjrNOEpldHWJHFbbPvzKXEX2FM3b_P54FWA",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "No data")")
                return
            }
            
            do {
                let popularMoviesResponse = try JSONDecoder().decode(PopularMoviesResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.delegate?.displayData(value: popularMoviesResponse.results)
                }
            } catch {
                print("Erro ao decodificar")
            }
        }
        task.resume()
    }
}

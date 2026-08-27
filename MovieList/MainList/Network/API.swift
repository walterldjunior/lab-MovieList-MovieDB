//
//  API.swift
//  MovieList
//
//  Created by Walter Junior on 26/08/26.
//

import Foundation

enum API {
    case popular(page: Int)
    case posterPath(path: String)
    
    var baseURL: String {
        switch self {
        case .posterPath:
            return "https://image.tmdb.org/t/p/"
        default:
            return "https://api.themoviedb.org/3/"
        }
    }
    
    var endpoint: String {
        switch self {
        case let .popular(page):
            return "movie/popular?language=en-US&page=\(page)"
        case let .posterPath(path):
            return "w780\(path)"
        }
    }
    
    var headers: [String: String] {
        return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMWU5MjdkYmE4N2ZiZDljOTFmN2JmYjQ1ZmFmMDk3OCIsIm5iZiI6MTc4MDMzMTUwMC45ODU5OTk4LCJzdWIiOiI2YTFkYjNlYzg1ZjQ5YWRhMzBjYWI4OTciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.srDTDFaoYjrNOEpldHWJHFbbPvzKXEX2FM3b_P54FWA"]
    }
    
    var method: APIMethod {
        switch self {
        case .popular, .posterPath:
            return .get
        }
    }
    
    func buildURL() -> URL? {
        var url: URL? = URL(string: baseURL + endpoint)
        return url
    }
}

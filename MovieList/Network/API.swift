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
    case search(query: String, page: Int)
    
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
        case .popular:
            return "movie/popular"
        case .search:
            return "search/movie"
        case let .posterPath(path):
            return "w780\(path)"
        }
    }
    
    var headers: [String: String] {
        return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMWU5MjdkYmE4N2ZiZDljOTFmN2JmYjQ1ZmFmMDk3OCIsIm5iZiI6MTc4MDMzMTUwMC45ODU5OTk4LCJzdWIiOiI2YTFkYjNlYzg1ZjQ5YWRhMzBjYWI4OTciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.srDTDFaoYjrNOEpldHWJHFbbPvzKXEX2FM3b_P54FWA"]
    }
    
    var queryParameters: [URLQueryItem] {
        switch self {
        case let .popular(page):
            return [.init(name: "page", value: String(page)),
                    .init(name: "language", value: "en-US")]
        case .search(query: let query, page: let page):
            return [.init(name: "query", value: query),
                    .init(name: "language", value: "en-US"),
                    .init(name: "page", value: String(page))]
        case .posterPath(path: let path):
            return []
        }
    }
    
    var method: APIMethod {
        switch self {
        case .popular, .posterPath, .search:
            return .get
        }
    }
    
    func buildURL() -> URL? {
        var url: URL? = URL(string: baseURL + endpoint)
        url?.append(queryItems: queryParameters)
        return url
    }
}

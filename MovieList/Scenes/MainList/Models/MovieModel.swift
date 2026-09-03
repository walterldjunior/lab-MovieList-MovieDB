//
//  MovieModel.swift
//  MovieList
//
//  Created by Walter Junior on 01/06/26.
//

import Foundation

struct MovieModel: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
    
    func getPosterURL() -> URL? {
        if let posterPath {
            return API.posterPath(path: posterPath).buildURL()
        }
        return nil
    }
}

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
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
    
    func getPosterURL() -> URL? {
        if let posterPath {
            return API.posterPath(path: posterPath).buildURL()
        }
        return nil
    }
}

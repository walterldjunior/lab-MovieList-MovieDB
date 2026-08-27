//
//  NetworkManager.swift
//  MovieList
//
//  Created by Walter Junior on 26/08/26.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ api: API) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
    
    func request<T>(_ api: API) async throws -> T where T : Decodable {
        guard let url = api.buildURL() else {
            throw URLError(.badURL)
            // TODO: throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        api.headers.forEach { (key: String, value: String) in
            request.setValue(value, forHTTPHeaderField: key)
            
        }
        
        return try await decodeRequest(request)
    }
    
    // MARK: - Generic decode helper
    
    private func decodeRequest<T: Decodable>(_ request: URLRequest,
                                             decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

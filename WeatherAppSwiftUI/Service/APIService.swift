//
//  APIService.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 4.03.2024.
//

import Foundation

final class APIService {
    static let shared = APIService()

//    func fetchCurrentData(endpoint: Endpoint) async throws -> CurrentDataModel {
//        guard let url = URL(string: endpoint.url) else {
//            throw URLError(.badURL)
//        }
//
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return try JSONDecoder().decode(CurrentDataModel.self, from: data)
//    }
//    
//    func fetchForecastData(endpoint: Endpoint) async throws -> CurrentDataModel {
//        guard let url = URL(string: endpoint.url) else {
//            throw URLError(.badURL)
//        }
//
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return try JSONDecoder().decode(CurrentDataModel.self, from: data)
//    }
    
    func fetchData<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = URL(string: endpoint.url) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

//
//  Endpoint.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 4.03.2024.
//

import Foundation

enum Endpoint {
    enum Constant {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "dc20bc24c47b21345ee9feabc7a4539b"
    }

    case currentWeatherData(latitude: Double, longitude: Double) // case' e input verme associated value olmuş oluyor
    case forecastWeatherData(latitude: Double, longitude: Double)
    
    var url: String {
        switch self {
        case .currentWeatherData(let latitude, let longitude):
            return "\(Constant.baseURL)weather?lat=\(latitude)&lon=\(longitude)&apiKey=\(Constant.apiKey)&units=metric"
        case .forecastWeatherData(let latitude, let longitude):
            return "\(Constant.baseURL)forecast?lat=\(latitude)&lon=\(longitude)&apiKey=\(Constant.apiKey)&units=metric"
        }
    }
}

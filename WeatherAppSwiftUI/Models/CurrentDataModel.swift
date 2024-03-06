//
//  CurrentDataModel.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 4.03.2024.
//

import Foundation


struct WeatherData {
    var currentWeather: CurrentDataModel?
    var forecastWeather: ForecastDataModel?
    
    init() {}
}

// Hashable -> SwiftUI uygulamalarında veri modellerinizi Hashable yapmak, veri yönetimini ve kullanıcı arayüzünün düzgün çalışmasını sağlamak için önemlidir. Bu nedenle, SwiftUI'de kullanacağınız herhangi bir modelin Hashable olması genellikle iyi bir uygulama yöntemidir.
struct CurrentDataModel: Decodable {
    let coord: Coordinate?
    let weather: [Weather?]
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct Coordinate: Decodable, Hashable {
    let lon: Float?
    let lat: Float?
}

struct Weather: Decodable, Hashable {
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Decodable, Hashable {
    let temp: Float?
    let feelsLike: Float?
    let tempMin: Float?
    let tempMax: Float?
    let pressure: Int?
    let humidity: Int?
     
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Decodable, Hashable {
    let speed: Float?
    let deg: Int?
}

struct Clouds: Decodable, Hashable {
    let all: Int?
}

struct Sys: Codable, Hashable {
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

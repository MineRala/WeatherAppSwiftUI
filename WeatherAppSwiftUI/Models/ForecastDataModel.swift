//
//  ForecastDataModel.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 5.03.2024.
//

import Foundation

struct ForecastDataModel: Decodable {
    let cod: String?
    let message: Int?
    let cnt: Int?
    let list: [ForecastList?]
    let city: City?
}

struct ForecastList: Decodable, Hashable {
    let dt: Int?
    let main: ForecastMain?
    let weather: [Weather?]
    let clouds: Clouds?
    let wind: ForecastWind?
    let visibility: Int?
    let pop: Float?
    let rain: Rain?
    let sys: ForecastSys?
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

struct ForecastMain: Decodable, Hashable {
    let temp: Float?
    let feelsLike: Float?
    let tempMin: Float?
    let tempMax: Float?
    let pressure: Int?
    let seaLevel: Int?
    let grndLevel: Int?
    let humidity: Int?
    let tempKf: Float?
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case tempKf = "temp_kf"
    }
}

struct ForecastWind: Decodable, Hashable {
    let speed: Float?
    let deg: Int?
    let gust: Float?
}

struct Rain: Decodable, Hashable {
    let treeH: Float?

    enum CodingKeys: String, CodingKey {
        case treeH = "3h"
    }
}

struct ForecastSys: Codable, Hashable {
    let pod: String?
}

struct City: Decodable, Hashable {
    let id: Int?
    let name: String?
    let coord: Coordinate?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}

//
//  Enums.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 15.03.2024.
//

import Foundation

enum WeatherDataModel {
    case weather(CurrentDataModel?)
    case forecast(ForecastDataModel?)
}

enum LocationType {
    case add
    case display
}

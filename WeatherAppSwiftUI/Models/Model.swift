//
//  Model.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 28.02.2024.
//

import Foundation
import SwiftData

@Model
final class ItemModel: Identifiable{
    let id: String
    var timestamp: Date
    var title: String
    var desc: String
    var temp: Float
    var minTemp: Float
    var maxTemp: Float
    var lat: Float
    var long: Float
    var timezone: Int

    init(timeStamp: Date, title: String, desc: String,  temp: Float, minTemp: Float, maxTemp: Float, lat: Float, long: Float, timezone: Int) {
        self.id = UUID().uuidString
        self.timestamp = timeStamp
        self.title = title
        self.desc = desc
        self.temp = temp
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.lat = lat
        self.long = long
        self.timezone = timezone
    }
}

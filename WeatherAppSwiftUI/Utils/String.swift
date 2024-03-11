//
//  String.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 11.03.2024.
//

import Foundation

extension String {
    var convertToDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: self) ?? Date()
    }
}

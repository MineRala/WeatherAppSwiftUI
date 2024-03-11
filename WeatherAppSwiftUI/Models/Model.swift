//
//  Model.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 28.02.2024.
//

import Foundation

final class Model: Identifiable {
    let id = UUID()
    var title: String

    init(title: String) {
        self.title = title
    }
}

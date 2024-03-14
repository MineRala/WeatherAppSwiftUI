//
//  UserDefaults.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 13.03.2024.
//

import SwiftUI

//class UserDefaults: ObservableObject {
//    // Örnek bir kullanıcı tercihini depolamak için bir anahtar tanımlayalım
//    private let latitudeKey = "latitude"
//    private let longitudeKey = "longitude"
//
//    
//    // Kullanıcının yüksek skorunu depolamak için bir değişken
//    @Published var latitude: Float {
//        didSet {
//            UserDefaults.standard.set(latitude, forKey: latitudeKey) // Değişiklik yapıldığında UserDefaults'a kaydet
//        }
//    }
//    
//    @Published var longitude: Float {
//        didSet {
//            UserDefaults.standard.set(longitude, forKey: longitudeKey) // Değişiklik yapıldığında UserDefaults'a kaydet
//        }
//    }
//    
//    // UserDefaults'dan yüksek skoru yüklemek için bir initializer
//    init() {
//        self.latitude = UserDefaults.standard.integer(forKey: latitudeKey)
//    }
//}

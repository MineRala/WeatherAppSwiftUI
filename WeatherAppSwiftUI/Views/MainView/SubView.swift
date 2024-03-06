//
//  SubView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 26.02.2024.
//

import SwiftUI

struct SubView: View {
    var opacity: CGFloat
    @Binding var currentWeather: CurrentDataModel?

    var body: some View {
        Text(currentWeather?.name ?? "")
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding(.top, 34)
        ZStack {
            VStack {
                Text(currentWeather?.name ?? "")
                    .foregroundColor(.white)
                    .font(.system(size: 80))
                    .fontWeight(.thin)
                    .opacity(opacity)
                Text(currentWeather?.weather.first??.main ?? "")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(opacity)
                Text("Y: \(Int(round(currentWeather?.main?.tempMin ?? 0)))° D:\(Int(round(currentWeather?.main?.tempMax ?? 0)))°")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(opacity)
            }
        }
    }
}

#Preview {
    ContentView()
}

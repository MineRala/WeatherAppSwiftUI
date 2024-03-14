//
//  DataView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct DataListView: View {
    @Binding var currentWeather: CurrentDataModel?

    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                if let currentWeather {
                    let items = [
                        DataModel(icon: "thermometer.medium", title: "Temperature", value: currentWeather.main?.temp != nil ? String(Int(round(currentWeather.main?.temp ?? 0))) + "°" : "-" , desc: "Shows the temperature."),
                        DataModel(icon: "thermometer.high", title: "Felt Temperature", value: currentWeather.main?.feelsLike != nil ? String(Int(round(currentWeather.main?.feelsLike ?? 0))) + "°" : "-", desc: "Shows the temperature felt by the human body."),
                        DataModel(icon: "sunrise", title: "Sunrise", value: "\( currentWeather.sys?.sunrise?.sunriseAndSunsetValue ?? "-")".lowercased(), desc: "Shows the sunrise time."),
                        DataModel(icon: "sunset", title: "Sunset", value: "\( currentWeather.sys?.sunset?.sunriseAndSunsetValue ?? "-")".lowercased(), desc: "Shows the sunset time."),
                        DataModel(icon: "humidity", title: "Humidity", value: currentWeather.main?.humidity != nil ? String(Int(round(Double(currentWeather.main?.humidity ?? 0)))) + "g/m^3" : "-", desc: "Shows absolute humidity."),
                        DataModel(icon: "gauge.open.with.lines.needle.33percent", title: "Pressure", value: currentWeather.main?.pressure != nil ? String(Int(round(Double(currentWeather.main?.pressure ?? 0)))) + "hPa" : "-", desc: "Shows air pressure."),
                        DataModel(icon: "wind", title: "Wind Speed", value: currentWeather.wind?.speed != nil ? String(Int(round(currentWeather.wind?.speed ?? 0))) + "km/h" : "-", desc: "Shows the speed of atmospheric wind."),
                        DataModel(icon: "wind.circle", title: "Wind Degree", value: currentWeather.wind?.deg != nil ? String(Int(round(Double(currentWeather.wind?.deg ?? 0)))) + "°" : "-", desc: "Shows the degree of wind.")
                    ]
                    ForEach(items, id: \.self) { item in
                        DataListRowView(model: item)
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal, -12)
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    ContentView()
}

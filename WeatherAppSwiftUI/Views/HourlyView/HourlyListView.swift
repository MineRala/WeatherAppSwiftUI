//
//  HourlyListView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct HourlyListView: View {
    @Binding var forecastWeather: ForecastDataModel?
    @Binding var currentWeather: CurrentDataModel?
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Forecast".uppercased())
                .font(.headline)
                .padding(.top)
                .padding(.leading, 10)
                .foregroundColor(.white)
            Divider()
                .background(.black).opacity(0.3)
                .padding([.bottom, .leading], 10)
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 8) {
                    if let forecastWeather {
                        let subArray = Array(forecastWeather.list.prefix(8))
                        ForEach(subArray, id: \.self){ item in
                            HourlyListColumnView(forecast: item)
                                .frame(width: 50, height: 80)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 12)
            }
            .scrollIndicators(.hidden)
        }
        .background(Color.blue.opacity(0.8))
    }
}

#Preview {
    ContentView()
}

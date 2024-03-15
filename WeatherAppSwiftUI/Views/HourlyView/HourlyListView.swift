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
            HStack {
                Image(systemName: "calendar.circle")
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(.white)
                Text("Daily Forecast".uppercased())
                    .foregroundColor(.white)
                    .padding(.leading, 4)
                    .font(.headline)
            }
            .padding([.top, .leading])
            Divider()
                .background(.black).opacity(0.3)
                .padding([.bottom, .leading], 10)
            ScrollView(.horizontal, showsIndicators: false) {
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
        }
        .background(Color.blue.opacity(0.8))
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

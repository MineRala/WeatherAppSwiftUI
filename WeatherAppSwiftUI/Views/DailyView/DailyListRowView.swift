//
//  DailyListRowView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct DailyListRowView: View {
    let items: [ForecastList?]
    var body: some View {
        HStack() {
            Text(formatDate(dtStr: items[0]?.dtTxt ?? "").dayNameOrToday)
                .foregroundColor(.white)
                .frame(maxWidth: 80, minHeight: 20, alignment: .leading)
                .font(.subheadline)
                .fontWeight(.bold)
            VStack {
                Spacer()
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(items[0]?.weather[0]?.icon ?? "")@2x.png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {}
                .frame(width: 32, height: 32)
                .foregroundColor(.white)
                .padding(.leading, 4)
                Spacer()
            }
            .padding(.top, 4)
            HStack {
                Text("\(Int(round(minTempMin())))°")
                    .foregroundColor(.white)
                    .font(.title3)
                    .frame(maxWidth: 40, alignment: .trailing)
                Rectangle()
                    .frame(width: 80, height: 3)
                    .foregroundColor(.white)
                Text("\(Int(round(maxTempMax())))°")
                    .foregroundColor(.white)
                    .font(.title3)
                    .frame(maxWidth: 40 , alignment: .trailing)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .listRowBackground(Color.clear)
        .cornerRadius(10)
    }
    
    private func formatDate(dtStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: dtStr) ?? Date()
    }
    
    private func minTempMin() -> Float {
        guard let firstTempMin = items[0]?.main?.tempMin else { return 0.0 }
        let minTemp = items.compactMap { $0?.main?.tempMin }.min() ?? firstTempMin
        return min(firstTempMin, minTemp)
    }
    
    private func maxTempMax() -> Float {
        guard let firstTempMax = items[0]?.main?.tempMax else { return 0.0 }
        let maxTemp = items.compactMap { $0?.main?.tempMin }.max() ?? firstTempMax
        return max(firstTempMax, maxTemp)
    }
    
    
}

#Preview {
    //    DailyListRowView()
    //        .background(.blue)
    ContentView()
}

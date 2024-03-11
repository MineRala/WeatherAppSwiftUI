//
//  DailyListView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct DailyListView: View {
    @Binding var forecastWeather: ForecastDataModel?
    var groupedItems: [[ForecastList?]] {
        guard let forecastWeather else { return [] }
        let groupedDictionary = Dictionary(grouping: forecastWeather.list) { item in
            formatDate(dtStr: item?.dtTxt ?? "")
        }
        return groupedDictionary.sorted { $0.key < $1.key }.map { $0.value }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(.white)
                Text("\(groupedItems.count)-Day Forecast".uppercased())
                    .foregroundColor(.white)
                    .padding(.leading, 4)
                    .font(.headline)
            }
            .padding([.top, .leading])
            Divider()
                .background(.black).opacity(0.3)
                .padding([.bottom, .leading], 10)
            List {
                if let forecastWeather {
                    ForEach(groupedItems, id: \.self) { items in
                        DailyListRowView(items: items)
                            .frame(height: 10)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            } .listStyle(PlainListStyle())
        }
        .frame(height: CGFloat((groupedItems.count + 1)) * 50)
        .background(Color.blue.opacity(0.8))
//        .frame(maxHeight: .infinity)
    }
    
    private func formatDate(dtStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dtStr) ?? Date()
        
        formatter.dateFormat = "yyyy-MM-dd"
        let string = formatter.string(from: date)
        return formatter.date(from: string) ?? Date()
    }
}

#Preview {
    ContentView()
}

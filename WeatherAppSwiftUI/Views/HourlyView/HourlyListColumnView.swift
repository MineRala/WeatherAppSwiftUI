//
//  HourlyListColumnView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 26.02.2024.
//

import SwiftUI

struct HourlyListColumnView: View {
    var forecast: ForecastList?
    @State var image: UIImage?
    var body: some View {
        VStack(alignment: .center) {
            Text(formatDate(dtStr:forecast?.dtTxt ?? ""))
                .fontWeight(.medium)
            Spacer()
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast?.weather[0]?.icon ?? "")@2x.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
            }
            Spacer()
            Text("\(Int(forecast?.main?.temp ?? 0))°")
                .fontWeight(.medium)
        }
    }
    
    func formatDate(dtStr: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dtStr) ?? Date()
        
        formatter.dateFormat = "HH:mm"
        let dateStr = formatter.string(from: date)
        return dateStr
    }
}

#Preview {
    ContentView()
}

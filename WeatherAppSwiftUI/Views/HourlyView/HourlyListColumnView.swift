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
            Text(forecast?.dtTxt?.convertToDate.hourBasicIdentifier ?? "")
                .fontWeight(.medium)
            Spacer()
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast?.weather[0]?.icon ?? "")@2x.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
            }
            .frame(width: 32, height: 32)
            Spacer()
            Text(forecast?.main?.temp != nil ? String(Int(round(forecast?.main?.temp ?? 0))) + "°" : "-")
                .fontWeight(.medium)
        }
    }
}

#Preview {
    ContentView()
}

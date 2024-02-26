//
//  ContentView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SubView()
                HourlyListView()
                    .cornerRadius(10)
                DailyListView()
                    .frame(height: 10 * 50)
                    .cornerRadius(10)
                DataListView()
            }
            .frame(width: UIScreen.main.bounds.width - 40)
        }
        .scrollIndicators(.hidden)
        .background(
            Image("hv")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    ContentView()
}

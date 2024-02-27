//
//  ContentView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
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
            .tabItem {
                Image(systemName: "1.circle")
            }
            .scrollIndicators(.hidden)
            .background(
                Image("hv")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            
            AddView()
                .background(.blue.opacity(0.5))
                .tabItem {
                    Image(systemName: "2.circle")
                }
        }
        .onAppear() {
                UITabBar.appearance().backgroundColor = .lightGray
            }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}

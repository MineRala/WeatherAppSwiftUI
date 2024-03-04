//
//  ContentView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var selection = 0
    @State private var isRowTapped = false
    
    init() {
        UITabBar.appearance().barTintColor = .black
        let standardAppearance = UITabBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.backgroundColor = UIColor.black
        UITabBar.appearance().standardAppearance = standardAppearance
        UITabBar.appearance().scrollEdgeAppearance = standardAppearance
    }
    
    var body: some View {
        TabView(selection: $selection) {
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
            .tag(0)
            .scrollIndicators(.hidden)
            .background(
                Image("hv")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.top, .leading, .trailing])
            )
            AddView(isRowTapped: $isRowTapped )
                .tabItem {
                    Image(systemName: "2.circle")
                }
                .tag(1)
        }
        .onReceive(Just(isRowTapped)) { tapped in
            if tapped {
                selection = 0
                isRowTapped = false
            }
        }
        .accentColor(.blue)
        .background(Color.red)
    }
}

#Preview {
    ContentView()
}

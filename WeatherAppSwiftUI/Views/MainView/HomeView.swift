//
//  HomeView.swift
//  WeatherAppSwiftUI
//
//  Created by Hakan Ugras on 27.02.2024.
//

import SwiftUI
import Combine
import CoreLocation

struct HomeView: View {
    @State private var selection = 0
    @State private var isRowTapped = false
    @State var currentWeather: CurrentDataModel?
    @State var forecastWeather: ForecastDataModel?
    @State var offset: CGFloat = 0
    @StateObject var locationDataManager = LocationDataManager()

    init() {
        UITabBar.appearance().barTintColor = .black
        let standardAppearance = UITabBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.backgroundColor = UIColor.black
        UITabBar.appearance().standardAppearance = standardAppearance
        UITabBar.appearance().scrollEdgeAppearance = standardAppearance
    }
    var body: some View {
        if currentWeather == nil || forecastWeather == nil {
            ProgressView("Loading")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
                .onChange(of: locationDataManager.authorizationStatus, { oldValue, newValue in
                    switch locationDataManager.locationManager.authorizationStatus {
                    case .authorizedWhenInUse, .authorizedAlways:
                        Task {
                            await fetchData()
                        }
                    case .restricted, .denied:
                        Text("Current location data was restricted or denied.")
                    case .notDetermined:
                        Text("Finding your location...")
                        ProgressView()
                    default:
                        ProgressView()
                    }
                })
        } else {
            TabView(selection: $selection) {
                ScrollView {
                    VStack(spacing: 16) {
                        SubView(opacity: getTitleOpacity(), currentWeather: $currentWeather)
                            .offset(y: -offset)
                            .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                            .offset(y: getTitleOffset())
                        HourlyListView()
                            .cornerRadius(10)
                        DailyListView()
                            .frame(height: 10 * 50)
                            .cornerRadius(10)
                        DataListView()
                    }
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .overlay(
                        GeometryReader { proxy -> Color in
                            let minY = proxy.frame(in: .named("scroll")).minY
                            
                            Task { @MainActor in
                                self.offset = minY
                            }
                            return Color.clear
                        }
                    )
                }
                .coordinateSpace(name: "scroll")
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
                AddView(isRowTapped: $isRowTapped)
                    .background(.blue.opacity(0.5))
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
    
    func fetchData() async {
        do {
            if let latitude = locationDataManager.locationManager.location?.coordinate.latitude, let longitude = locationDataManager.locationManager.location?.coordinate.longitude {
                self.currentWeather = try await APIService.shared.fetchData(endpoint: .currentWeatherData(latitude: Float(latitude), longitude: Float(longitude)))
                print("currentWeather finished")
                self.forecastWeather  = try await APIService.shared.fetchData(endpoint: .forecastWeatherData(latitude: Float(latitude), longitude: Float(longitude)))
                print("forecastWeather finished")
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getTitleOpacity() -> CGFloat {
        let titleOffset = -getTitleOffset()
        
        let progress = titleOffset / 30
        
        let opacity = 1 - progress
        
        return opacity
    }
    
    func getTitleOffset() -> CGFloat {
        if offset < 0 {
            let progress = -offset / 180
            
            let newOffset = (progress <= 1 ? progress : 1) * 30
            
            return -newOffset
        }
        
        return 0
    }
}

#Preview {
    ContentView()
}
                       

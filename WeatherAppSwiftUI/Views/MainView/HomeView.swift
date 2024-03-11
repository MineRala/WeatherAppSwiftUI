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
    @State private var locationDeniedAlertShow = false
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
        TabView(selection: $selection) {
            ScrollView {
                VStack(spacing: 16) {
                    SubView(opacity: getTitleOpacity(), currentWeather: $currentWeather)
                        .offset(y: -offset)
                        .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                        .offset(y: getTitleOffset())
                    HourlyListView(forecastWeather: $forecastWeather, currentWeather: $currentWeather)
                        .cornerRadius(10)
                    DailyListView(forecastWeather: $forecastWeather)
//                        .frame(height: 6 * 50)
                        .cornerRadius(10)
                    DataListView(currentWeather: $currentWeather)
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
                    .blur(radius: 20)
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
        .onChange(of: locationDataManager.authorizationStatus, { _, _ in
            switch locationDataManager.authorizationStatus {
            case .restricted, .denied:
                locationDeniedAlertShow = true
            case .authorizedAlways, .authorizedWhenInUse, .authorized:
                Task {
                    await fetchData()
                }
            default:
                break
            }
        })
        .alert("Location Permission is Denied", isPresented: $locationDeniedAlertShow) {
            Button("Settings") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                   UIApplication.shared.open(settingsUrl)
                 }
            }
            Button("Dismiss", role: .cancel) { }
        }
    }
    
    private func fetchData() async {
        do {
            if let latitude = locationDataManager.locationManager.location?.coordinate.latitude, let longitude = locationDataManager.locationManager.location?.coordinate.longitude {
                let result = try await withThrowingTaskGroup(of: WeatherDataModel.self, returning: (CurrentDataModel?, ForecastDataModel?).self) { group in
                    group.addTask {
                        let weather: CurrentDataModel? = try await APIService.shared.fetchData(endpoint: .currentWeatherData(latitude: Float(latitude), longitude: Float(longitude)))
                        return .weather(weather)
                    }
                    group.addTask {
                        let forecast: ForecastDataModel? = try await APIService.shared.fetchData(endpoint: .forecastWeatherData(latitude: Float(latitude), longitude: Float(longitude)))
                        return .forecast(forecast)
                    }
                    
                    var weather: CurrentDataModel?
                    var forecast: ForecastDataModel?
                    
                    for try await result in group {
                        switch result {
                        case .weather(let value):
                            weather = value
                        case .forecast(let value):
                            forecast = value
                        }
                    }
                    
                    return (weather, forecast)
                }
                
                self.currentWeather = result.0
                self.forecastWeather = result.1
            } else {
                print("No location")
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func getTitleOpacity() -> CGFloat {
        let titleOffset = -getTitleOffset()
        
        let progress = titleOffset / 30
        
        let opacity = 1 - progress
        
        return opacity
    }
    
    private func getTitleOffset() -> CGFloat {
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

enum WeatherDataModel {
    case weather(CurrentDataModel?)
    case forecast(ForecastDataModel?)
}


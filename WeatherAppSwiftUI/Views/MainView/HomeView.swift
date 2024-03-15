//
//  HomeView.swift
//  WeatherAppSwiftUI
//
//  Created by Hakan Ugras on 27.02.2024.
//

import SwiftUI
import CoreLocation
import SwiftData

struct HomeView: View {
    @State private var selection = 0
    @State var currentWeather: CurrentDataModel?
    @State var forecastWeather: ForecastDataModel?
    @State var offset: CGFloat = 0
    @State private var locationDeniedAlertShow = false
    @StateObject var locationDataManager = LocationDataManager()
    @State var newModel: ItemModel?

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
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    SubView(opacity: getTitleOpacity(), currentWeather: $currentWeather)
                        .offset(y: -offset)
                        .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                        .offset(y: getTitleOffset())
                    HourlyListView(forecastWeather: $forecastWeather, currentWeather: $currentWeather)
                        .cornerRadius(10)
                    DailyListView(forecastWeather: $forecastWeather)
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
                Image(systemName: "house")
            }
            .tag(0)
            .background(
                Image("hv")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.top, .leading, .trailing])
                    .blur(radius: 20)
            )
            AddView(viewModel: AddViewModel(), newModel: $newModel) { type, item in
                Task {
                    UserDefaults.standard.set(item.latitude, forKey: "latitude")
                    UserDefaults.standard.set(item.longitude, forKey: "longitude")
                    await fetchWeather(lat: item.latitude, long: item.longitude)
                    selection = 0
                    if type == .add {
                        newModel =  ItemModel(
                            timeStamp: Date(),
                            title: currentWeather?.name ?? "",
                            desc: currentWeather?.weather.first??.main ?? "",
                            temp: currentWeather?.main?.temp ?? 0,
                            minTemp: currentWeather?.main?.tempMin ?? 0,
                            maxTemp: currentWeather?.main?.tempMax ?? 0,
                            lat: Float(item.latitude),
                            long: Float(item.longitude),
                            timezone: currentWeather?.timezone ?? 0
                        )
                      
                    }
                }
            }
            .modelContainer(for: ItemModel.self)
            .background(.blue.opacity(0.5))
            .tabItem {
                Image(systemName: "list.bullet")
            }
            .tag(1)
        }
        .accentColor(.blue)
        .background(Color.red)
        .onChange(of: locationDataManager.authorizationStatus, { _, _ in
            switch locationDataManager.authorizationStatus {
            case .restricted, .denied:
                locationDeniedAlertShow = true
            case .authorizedAlways, .authorizedWhenInUse, .authorized:
                Task {
                    await fetchWeather()
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
}

// MARK: - Functionalities
extension HomeView {
    private func fetchWeather(lat: Double? = nil, long: Double? = nil) async {
        // Koordinatları belirle
        guard let coordinate = determineCoordinate(lat: lat, long: long) else {
            print("Error: Coordinate is nil")
            return
        }

        // Hava durumu verilerini al
        do {
            let (currentWeather, forecastWeather) = try await fetchCurrentAndForecastWeather(coordinate: coordinate)
            self.currentWeather = currentWeather
            self.forecastWeather = forecastWeather
        } catch {
            print("Error: \(error)")
        }
    }

    private func determineCoordinate(lat: Double?, long: Double?) -> (Double, Double)? {
        if let lat, let long {
            return (lat, long)
        } else if let lat = UserDefaults.standard.object(forKey: "latitude") as? Double, let long = UserDefaults.standard.object(forKey: "longitude") as? Double {
            return(lat, long)
        } else if let location = locationDataManager.locationManager.location  {
            return (location.coordinate.latitude, location.coordinate.longitude)
        }
        return nil
    }

    private func fetchCurrentAndForecastWeather(coordinate: (Double, Double)) async throws -> (CurrentDataModel?, ForecastDataModel?) {
        // Hava durumu verilerini alma işlemi
        return try await withThrowingTaskGroup(of: (CurrentDataModel?, ForecastDataModel?).self) { group in
            group.addTask {
                let weather: CurrentDataModel? = try await APIService.shared.fetchData(endpoint: .currentWeatherData(latitude: Float(coordinate.0), longitude: Float(coordinate.1)))
                return (weather, nil)
            }
            group.addTask {
                let forecast: ForecastDataModel? = try await APIService.shared.fetchData(endpoint: .forecastWeatherData(latitude: Float(coordinate.0), longitude: Float(coordinate.1)))
                return (nil, forecast)
            }
            
            var weather: CurrentDataModel?
            var forecast: ForecastDataModel?
            
            for try await (currentItem, forecastItem) in group {
                if let currentWeather = currentItem {
                    weather = currentWeather
                }
                if let forecastWeather = forecastItem {
                    forecast = forecastWeather
                }
            }
            
            return (weather, forecast)
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

// MARK: - Preview
#Preview {
    ContentView()
}

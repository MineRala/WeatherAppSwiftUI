//
//  AddView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 26.02.2024.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @State var isLocationList: Bool = true
    @State private var isPresented = false
    @State private var deleteItemIndex = 0
    @StateObject var viewModel: AddViewModel
    var sendData: (LocationType, AnnotationItem) -> Void
    @Environment(\.modelContext) private var context
    @Query private var items: [ItemModel]
    @Binding var newModel: ItemModel?
    
    init(viewModel: AddViewModel, newModel: Binding<ItemModel?>, sendData: @escaping (LocationType, AnnotationItem) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._newModel = newModel
        self.sendData = sendData
        Theme.navigationBarColors(background: .black, titleColor: .white)
    }
    
    var body: some View {
        NavigationView {
            List {
                if !isLocationList && viewModel.results.isEmpty {
                    NoResultsView(searchText: $viewModel.searchableText)
                } else {
                    if !isLocationList {
                        ForEach(viewModel.results) { item in
                            TextView(title: item.title)
                                .simultaneousGesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            Task {
                                                await viewModel.getPlace(from: item)
                                                await MainActor.run {
                                                    sendData(.add, viewModel.annotationItems.first ?? AnnotationItem(latitude: 1, longitude: 1))
                                                }
                                            }
                                        }
                                )
                        }
                    } else {
                        ForEach(items) { item in
                            PlaceRowView(item: item)
                                .onTapGesture {
                                    Task {
                                        await MainActor.run {
                                            let annotationItem = AnnotationItem(latitude: Double(item.lat), longitude: Double(item.long))
                                            sendData(.display, annotationItem)
                                        }
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 40, height: 85)
                                .swipeActions {
                                    Button(action: {
                                        if let index = items.firstIndex(of: item) {
                                            deleteItem(at: index)
                                        }
                                    }) {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                }
                                .padding([.top, .bottom])
                                .listRowBackground(Color.black)
                        }
                        .background(Color.black)
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .background(Color.black)
            .scrollContentBackground(.hidden)
            .searchable(text: $viewModel.searchableText, prompt: "Search for a city or airport")
            .onChange(of: viewModel.searchableText) { _, newValue in
                isLocationList = viewModel.searchableText.isEmpty
                viewModel.searchAddress(newValue)
            }
            .onChange(of: newModel) { _, newModelValue in
                if let new = newModelValue {
                    context.insert(new)
                }
            }
            .onAppear {
                for item in items {
                   fetchAndUpdateItem(item)
                }
            }
            .navigationTitle("Weather")
        }
    }
    
    private func deleteItem(at index: Int) {
        let model = items[index]
        deleteModelFromUserDefaults(model)
        context.delete(model)
        try? context.save()
    }
    
    private func deleteModelFromUserDefaults(_ model: ItemModel) {
        if let savedLatitude = UserDefaults.standard.object(forKey: "latitude") as? Double,  let savedLongitude =  UserDefaults.standard.object(forKey: "longitude") as? Double, savedLatitude == Double(model.lat), savedLongitude == Double(model.long) {
            UserDefaults.standard.removeObject(forKey: "latitude")
            UserDefaults.standard.removeObject(forKey: "longitude")
            print("Longitude değeri silindi.")
        } else {
            print("Silinecek bir Longitude değeri bulunamadı.")
        }
    }
    
    private func fetchAndUpdateItem(_ item: ItemModel) {
        let coordinates = (item.lat, item.long)
        Task {
            do {
                let currentWeather: CurrentDataModel = try await APIService.shared.fetchData(endpoint: .currentWeatherData(latitude: coordinates.0, longitude: coordinates.1))
                item.timestamp = Date()
                item.title = currentWeather.name ?? ""
                item.desc = currentWeather.weather.first??.main ?? ""
                item.temp = currentWeather.main?.temp ?? 0
                item.minTemp = currentWeather.main?.tempMin ?? 0
                item.maxTemp = currentWeather.main?.tempMax ?? 0
                try? context.save()
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

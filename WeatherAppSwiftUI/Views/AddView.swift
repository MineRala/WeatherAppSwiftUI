//
//  AddView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 26.02.2024.
//

import SwiftUI

struct AddView: View {
    @State var searchText = ""
    @State var isLocationList: Bool = true
    @State private var isPresented = false
    @State private var deleteItemIndex = 0
    @State  var list: [Model] = [Model(title: "kdfjkd"), Model(title: "laİŞ"), Model(title: "weowekwl"), Model(title: "falka"), Model(title: "MKSMD")]
    @State  var lists: [String] = ["kdfjkd", "laİŞ", "weowekwl", "falka", "MKSMD", "fama"]
    @Binding var isRowTapped: Bool
    
    init(isRowTapped: Binding<Bool>) {
        _isRowTapped = isRowTapped
        Theme.navigationBarColors(background: .black, titleColor: .white)
    }
    
    var searchResults: [String] {
        guard !isLocationList else { return [] }
        if searchText.isEmpty {
            return lists
        } else {
            return lists.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                if !isLocationList && searchResults.isEmpty {
                    NoResultsView(searchText: $searchText)
                        .listRowBackground(Color.black)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                } else {
                    if !isLocationList {
                        ForEach(searchResults, id: \.self) { item in
                            Text(item.capitalized)
                                .listRowBackground(Color.black)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    } else {
                        ForEach(Array(list.enumerated()), id: \.element.id) { index, item in
                            PlaceRowView()
                                .onTapGesture {
                                    isRowTapped = true
                                }
                                .frame(width: UIScreen.main.bounds.width - 40, height: 85)
                                .swipeActions {
                                    Button(action: {
                                        print("Delete Index: \(index), Delete Item: \(item)")
                                        list.remove(at: index)
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
            .searchable(text: $searchText, prompt: "Şehir veya havaalanı arayın")
            .onChange(of: searchText) { _, _ in
                isLocationList = searchText.isEmpty
            }
            .navigationTitle("Hava Durumu")
        }
    }
}

#Preview {
    AddView(isRowTapped: .constant(true))
}

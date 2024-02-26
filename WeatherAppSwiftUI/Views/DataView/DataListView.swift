//
//  DataView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct DataListView: View {
    let items = Array(1...8)
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(items, id: \.self) { item in
                    DataListRowView()
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.leading, -12)
            .padding(.trailing, -12)
        }
    }
}

#Preview {
    DataListView()
}

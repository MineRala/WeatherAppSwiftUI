//
//  NoResultsView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 28.02.2024.
//

import SwiftUI

struct NoResultsView: View {
    @Binding var searchText: String

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
            Text("No Results")
                .foregroundColor(.white)
                .font(.title2)
            Text("No results found for \"\(searchText)\"")
                .foregroundColor(.gray)
                .font(.title3)
        }
        .listRowBackground(Color.black)
        .frame(maxWidth: .infinity)
        .background(.black)
        .padding()
    }
}

#Preview {
    NoResultsView(searchText: .constant("Search"))
        .background(.black)
}

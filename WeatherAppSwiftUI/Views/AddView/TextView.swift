//
//  TextView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 12.03.2024.
//

import SwiftUI

struct TextView: View {
    @Environment(\.dismissSearch) private var dismissSearch
    var title: String

    var body: some View {
        Text(title.capitalized)
            .listRowBackground(Color.black)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
                dismissSearch()
            }
    }
}

#Preview {
    TextView(title: "Example")
}

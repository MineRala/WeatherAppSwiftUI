//
//  DataListRowView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 26.02.2024.
//

import SwiftUI

struct DataListRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "humidity")
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(.black.opacity(0.5))
                Text("Humidity".uppercased())
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.leading, 4)
            }
            Text("55%")
                .foregroundColor(.white)
                .font(.title)
            Spacer(minLength: 16)
            Text("The dew point is 36° right now.")
                .foregroundColor(.white)
                .font(.subheadline)
        }
        .padding(.all)
    }
}

#Preview {
    DataListRowView()
        .background(.blue)
        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
}

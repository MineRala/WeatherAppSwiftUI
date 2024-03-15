//
//  PlaceRowView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 28.02.2024.
//

import Foundation
import SwiftUI

struct PlaceRowView: View {
    var item: ItemModel
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(item.title)
                Text(item.timestamp.hourAndMinuteIdentifier(timezone: item.timezone))
                Spacer()
                Text(item.desc)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(Int(round(item.temp)))°")
                    .font(.system(size: 40))
                Spacer()
                Text("L:\(Int(round(item.minTemp)))° H:\(Int(round(item.maxTemp)))°")
            }
        }
        .padding()
        .background(
            Image("hv")
                .resizable()
                .scaledToFill()
               
                .edgesIgnoringSafeArea(.all)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

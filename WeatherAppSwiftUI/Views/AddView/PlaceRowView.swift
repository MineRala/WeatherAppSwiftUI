//
//  PlaceRowView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 28.02.2024.
//

import SwiftUI

struct PlaceRowView: View {
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text("Konumum")
                Text("İzmir")
                Spacer()
                Text("Çok Bulutlu")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("14°")
                    .font(.system(size: 40))
                Spacer()
                Text("D:10° Y:20°")
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

#Preview {
    PlaceRowView()
        .frame(width: UIScreen.main.bounds.width - 40, height: 85)
        .cornerRadius(12)
}

//
//  SubView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 26.02.2024.
//

import SwiftUI

struct SubView: View {
    var body: some View {
        Text("İzmir")
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding(.top, 34)
        ZStack {
            HStack {
                Text("17°")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 3, height: 25)
                Text("Çok Bulutlu")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
            }.opacity(0)
            VStack {
                Text("17°")
                    .foregroundColor(.white)
                    .font(.system(size: 80))
                    .fontWeight(.thin)
                Text("Çok Bulutlu")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Y: 17° D:7°")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
           
        }
    }
}

#Preview {
    SubView()
        .background(.blue)
}

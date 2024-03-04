//
//  SubView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 26.02.2024.
//

import SwiftUI

struct SubView: View {
    var opacity: CGFloat
    var body: some View {
        Text("İzmir")
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding(.top, 34)
        ZStack {
            VStack {
                Text("17°")
                    .foregroundColor(.white)
                    .font(.system(size: 80))
                    .fontWeight(.thin)
                    .opacity(opacity)
                Text("Çok Bulutlu")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(opacity)
                Text("Y: 17° D:7°")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(opacity)
            }
           
        }
    }
}

#Preview {
    ContentView()
}

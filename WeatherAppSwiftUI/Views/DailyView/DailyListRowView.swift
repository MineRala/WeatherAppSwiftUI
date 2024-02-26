//
//  DailyListRowView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct DailyListRowView: View {
    @Binding var isPercentage: Bool
    var body: some View {
        HStack() {
            Text("Bugün")
                .foregroundColor(.white)
                .frame(minHeight: 20, alignment: .leading)
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()
            VStack {
                Image(systemName: "smoke")
                    .frame(width: 16, height: 16)
                    .foregroundColor(.white)
                    .padding(.leading, 4)
                if isPercentage {
                    Text("60%")
                        .foregroundColor(.black)
                        .font(.footnote)
                }
            }
            .padding(.top, 4)
            Spacer()
            Text("22°")
                .foregroundColor(.white)
                .font(.title3)
            Rectangle()
                .frame(width: 50, height: 3)
                .foregroundColor(.white)
            Text("36°")
                .foregroundColor(.white)
                .font(.title3)
        }
        .padding()
        .listRowBackground(Color.clear)
        .cornerRadius(10)
    }
}

#Preview {
    DailyListRowView(isPercentage: .constant(false))
        .background(.blue)
}

//
//  HourlyListColumnView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 26.02.2024.
//

import SwiftUI

struct HourlyListColumnView: View {
    @Binding var isPercentage: Bool
    var body: some View {
        VStack(alignment: .center) {
            Text("Now")
            Spacer()
            Image(systemName: "sun.min")
            if isPercentage {
                Text("60%")
                    .foregroundStyle(.black)
                    .font(.footnote)
                    .padding(.top,2)
            }
            Spacer()
            Text("30°")
        }
    }
}

#Preview {
    HourlyListColumnView(isPercentage: .constant(false))
}

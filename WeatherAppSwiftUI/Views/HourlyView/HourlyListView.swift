//
//  HourlyListView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct HourlyListView: View {
    let items = Array(1...25)
    @State var isPercentage: Bool = true
    var body: some View {
        VStack(alignment: .leading) {
            Text("18:00 itibariyle güneşli hava durumu bekleniyor.")
                .padding(.top)
                .padding(.leading, 4)
                .foregroundColor(.white)
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .padding(.leading, 10)
                .frame(width: UIScreen.main.bounds.width - 50, height: 0.3)
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 8) {
                    ForEach(items, id: \.self){ item in
                        HourlyListColumnView(isPercentage: $isPercentage)
                            .frame(width: 50, height: isPercentage ? 85 : 80)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 12)
            }
            .scrollIndicators(.hidden)
        }
        .background(Color.blue.opacity(0.8))
    }
}

#Preview {
    HourlyListView()
}

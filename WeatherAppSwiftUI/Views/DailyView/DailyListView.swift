//
//  DailyListView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct DailyListView: View {
    @State var isPercentage = true
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(.white)
                Text("10-Day Forecast".uppercased())
                    .foregroundColor(.white)
                    .padding(.leading, 4)
            }
            .padding([.top, .leading])
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .padding(.leading, 10)
                .frame(width: UIScreen.main.bounds.width - 50, height: 0.3)
            List {
                ForEach(1..<11, id: \.self) { _ in
                    DailyListRowView(isPercentage: $isPercentage)
                        .frame(height: 10)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            } .listStyle(PlainListStyle())
        }
        .background(Color.blue.opacity(0.8))
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    DailyListView()
}

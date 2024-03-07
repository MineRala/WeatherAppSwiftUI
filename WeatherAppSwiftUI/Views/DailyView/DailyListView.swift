//
//  DailyListView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct DailyListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(.white)
                Text("10-Day Forecast".uppercased())
                    .foregroundColor(.white)
                    .padding(.leading, 4)
                    .font(.headline)
            }
            .padding([.top, .leading])
            Divider()
                .background(.black).opacity(0.3)
                .padding([.bottom, .leading], 10)
            List {
                ForEach(1..<11, id: \.self) { _ in
                    DailyListRowView()
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

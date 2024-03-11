//
//  DataListRowView.swift
//  WeatherAppSwiftUI
//
//  Created by Mine Rala on 26.02.2024.
//

import SwiftUI

struct DataListRowView: View {
    let model: DataModel
    var body: some View {
        VStack {
            HStack {
                Image(systemName: model.icon)
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(.black.opacity(0.5))
                Text(model.title.uppercased())
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.leading, 4)
                    .font(.footnote)
                    .minimumScaleFactor(0.5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer(minLength: 4)
            Text(model.value)
                .foregroundColor(.white)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer(minLength: 4)
            Text(model.desc)
                .foregroundColor(.white)
                .font(.subheadline)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.all)
    }
}

#Preview {
//    DataListRowView()
//        .background(.blue)
//        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
    ContentView()
}

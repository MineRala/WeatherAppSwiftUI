//
//  HomeView.swift
//  WeatherAppSwiftUI
//
//  Created by Hakan Ugras on 27.02.2024.
//

import SwiftUI

struct HomeView: View {
    @State var offset: CGFloat = 0
    var body: some View {
        TabView {
            ScrollView {
                VStack(spacing: 16) {
                    SubView(opacity: getTitleOpacity())
                        .offset(y: -offset)
                        .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                        .offset(y: getTitleOffset())
                    HourlyListView()
                        .cornerRadius(10)
                    DailyListView()
                        .frame(height: 10 * 50)
                        .cornerRadius(10)
                    DataListView()
                }
                .frame(width: UIScreen.main.bounds.width - 40)
                .overlay(
                    GeometryReader { proxy -> Color in
                        let minY = proxy.frame(in: .named("scroll")).minY
                        
                        Task { @MainActor in
                            self.offset = minY
                        }
                        return Color.clear
                    }
                )
            }
            .coordinateSpace(name: "scroll")
            .tabItem {
                Image(systemName: "1.circle")
            }
            .scrollIndicators(.hidden)
            .background(
                Image("hv")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            
            AddView()
                .background(.blue.opacity(0.5))
                .tabItem {
                    Image(systemName: "2.circle")
                }
        }
        .onAppear() {
                UITabBar.appearance().backgroundColor = .lightGray
            }
        .accentColor(.blue)
    }
    
    func getTitleOpacity() -> CGFloat {
        let titleOffset = -getTitleOffset()
        
        let progress = titleOffset / 30
        
        let opacity = 1 - progress
        
        return opacity
    }
    
    func getTitleOffset() -> CGFloat {
        if offset < 0 {
            let progress = -offset / 100
            
            let newOffset = (progress <= 1 ? progress : 1) * 30
            
            return -newOffset
        }
        
        return 0
    }
}

#Preview {
    ContentView()
}

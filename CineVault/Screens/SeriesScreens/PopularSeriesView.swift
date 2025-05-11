//
//  PopularSeriesView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct PopularSeriesView: View {
    @EnvironmentObject var viewModel: MovieDBViewModel
    let screenWidth = UIScreen.main.bounds.width
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(viewModel.popularSeries.indices, id: \.self) { index in
                            NavigationLink(destination: SeriesDetailView(imageName: viewModel.popularSeries[index].fullPosterPath, series: viewModel.popularSeries[index])) {
                                SeriesHighlightCell(series: viewModel.popularSeries[index], imageURL: viewModel.popularSeries[index].fullPosterPath)
                                    .frame(width: screenWidth, height: 460)
                                    .id(index)
                            }
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
                .scrollTargetBehavior(.viewAligned)
                .onAppear {
                    startAutoScroll(with: proxy)
                }
                .onDisappear {
                    stopAutoScroll()
                }
            }
        }
    }
    
    private func startAutoScroll(with proxy: ScrollViewProxy) {
        guard !viewModel.popularSeries.isEmpty else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % viewModel.popularSeries.count
                proxy.scrollTo(currentIndex, anchor: .center)
            }
        }
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    PopularSeriesView()
        .environmentObject(MovieDBViewModel())
}


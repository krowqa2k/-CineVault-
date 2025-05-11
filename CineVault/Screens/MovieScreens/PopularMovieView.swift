//
//  PopularMovieView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct PopularMovieView: View {
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
                        ForEach(viewModel.popular.indices, id: \.self) { index in
                            NavigationLink(destination: MovieDetailView(imageName: viewModel.popular[index].fullPosterPath, movie: viewModel.popular[index])) {
                                MovieHighlightCell(movie: viewModel.popular[index], imageURL: viewModel.popular[index].fullPosterPath)
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
        guard !viewModel.popular.isEmpty else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % viewModel.popular.count
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
    PopularMovieView()
        .environmentObject(MovieDBViewModel())
}



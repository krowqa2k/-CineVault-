//
//  MoviesMainView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct MoviesMainView: View {
    @StateObject private var viewModel: MoviesViewModel = MoviesViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            MoviesHighlightView(movieArray: viewModel.popular)
                .padding(.bottom, 0)
            
            MoviesScrollView(title: "Now Playing", movieArray: viewModel.trendings)
            
            MoviesScrollView(title: "Top Rated", movieArray: viewModel.topRated)
            
            MoviesScrollView(title: "Upcoming", movieArray: viewModel.upcoming)
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    MoviesMainView()
}

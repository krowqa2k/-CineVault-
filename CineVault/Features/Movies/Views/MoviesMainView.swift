//
//  MoviesMainView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct MoviesMainView: View {
    @StateObject private var viewModel: MoviesViewModel
    
    init(webService: WebServiceProtocol) {
        _viewModel = StateObject(wrappedValue: MoviesViewModel(webService: webService))
    }
    
    var body: some View {
        VStack(spacing: 24) {
            MoviesHighlightView(movieArray: viewModel.popular)
                .padding(.bottom, 0)
            
            MoviesScrollView(title: "Now Playing", movieArray: viewModel.trendings)
            
            MoviesScrollView(title: "Top Rated", movieArray: viewModel.topRated)
            
            MoviesScrollView(title: "Upcoming", movieArray: viewModel.upcoming)
        }
        .background(Color.blackDB)
        .environmentObject(viewModel)
    }
}

#Preview {
    let webService = WebService()
    
    MoviesMainView(webService: webService)
}

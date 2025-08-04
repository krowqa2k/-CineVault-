//
//  SeriesMainView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct SeriesMainView: View {
    @StateObject private var viewModel: SeriesViewModel = SeriesViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            SeriesHighlightView(seriesArray: viewModel.popularSeries)
                .padding(.bottom, 0)
            
            SeriesScrollView(title: "New Episode Today!", seriesArray: viewModel.airingToday)
            
            SeriesScrollView(title: "On Air Currently", seriesArray: viewModel.onTheAirSeries)
            
            SeriesScrollView(title: "Top Rated Series", seriesArray: viewModel.topRatedSeries)
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    SeriesMainView()
}

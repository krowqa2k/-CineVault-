//
//  SeriesMainView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct SeriesMainView: View {
    @StateObject private var viewModel: SeriesViewModel
    
    init(webService: WebServiceProtocol) {
        _viewModel = StateObject(wrappedValue: SeriesViewModel(webService: webService))
    }
    
    var body: some View {
        NavigationStack {
            if !viewModel.isLoading {
                ScrollView {
                    SeriesHighlightView(seriesArray: viewModel.popularSeries)
                        .padding(.bottom, 0)
                    
                    SeriesScrollView(title: "New Episode Today!", seriesArray: viewModel.airingToday)
                    
                    SeriesScrollView(title: "On Air Currently", seriesArray: viewModel.onTheAirSeries)
                    
                    SeriesScrollView(title: "Top Rated Series", seriesArray: viewModel.topRatedSeries)
                }
                .environmentObject(viewModel)
                .background(Color.blackDB)
                .refreshable {
                    await viewModel.refreshFetchData()
                }
            } else {
                ProgressView()
                    .font(.largeTitle)
            }
        }
        .task {
            if !viewModel.initialDataFetched {
                await viewModel.fetchInitialData()
            }
        }
    }
}

#Preview {
    let webService = WebService()
    
    SeriesMainView(webService: webService)
}

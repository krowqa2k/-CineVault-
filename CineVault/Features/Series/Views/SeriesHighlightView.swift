//
//  SeriesHighlightView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct SeriesHighlightView: View {
    @EnvironmentObject var viewModel: SeriesViewModel
    let seriesArray: [SeriesModel]

    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(seriesArray) { serie in
                        NavigationLink(
                            destination: SeriesDetailView(imageName: serie.fullPosterPath, series: serie)
                                .environmentObject(viewModel)
                        ) {
                            SeriesHighlightCell(series: serie, imageURL: serie.fullPosterPath)
                                .frame(height: screenWidth * 1.2)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
        }
    }
}

#Preview {
    let seriesArray: [SeriesModel] = [.mock, .mock, .mock]
    
    NavigationStack {
        SeriesHighlightView(seriesArray: seriesArray)
            .environmentObject(SeriesViewModel())
    }
}

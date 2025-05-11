//
//  SeriesListView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 05/10/2024.
//

import SwiftUI

struct SeriesListView<Content: View>: View {
    let title: String
    let viewAllDestination: Content
    let series: [SeriesModel] // Replace `Series` with your actual model type
    let getSeriesData: () -> Void
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack {
                        Text(title)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        NavigationLink(destination: viewAllDestination) {
                            Text("View all")
                                .font(.subheadline)
                                .foregroundStyle(.purpleDB)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(series) { seriesItem in
                                NavigationLink(destination: SeriesDetailView(imageName: seriesItem.fullPosterPath, series: seriesItem)) {
                                    SeriesCell(movie: seriesItem, imageURL: seriesItem.fullPosterPath)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 280)
                    .scrollIndicators(.hidden)
                }
            }
        }
        .task {
            getSeriesData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}


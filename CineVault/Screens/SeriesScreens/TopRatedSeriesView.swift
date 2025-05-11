//
//  TopRatedSeriesView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct TopRatedSeriesView: View {
    @EnvironmentObject var viewModel: DataBaseViewModel
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack() {
                        Text("Top Rated Series")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        NavigationLink(destination: TopRatedSeriesListView()) {
                            Text("View all")
                                .font(.subheadline)
                                .foregroundStyle(.purpleDB)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(viewModel.topRatedSeries){ topRatedSeries in
                                NavigationLink(destination: SeriesDetailView(imageName: topRatedSeries.fullPosterPath, series: topRatedSeries)) {
                                    SeriesCell(movie: topRatedSeries, imageURL: topRatedSeries.fullPosterPath)
                                }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 280)
                    .scrollIndicators(.hidden)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
}

#Preview {
    TopRatedSeriesView()
        .environmentObject(DataBaseViewModel())
}

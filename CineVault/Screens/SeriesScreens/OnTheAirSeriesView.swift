//
//  TrendingSeriesView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct OnTheAirSeriesView: View {
    @EnvironmentObject var viewModel: DataBaseViewModel
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack() {
                        Text("On Air Currently")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        NavigationLink(destination: OnTheAirSeriesListView()) {
                            Text("View all")
                                .font(.subheadline)
                                .foregroundStyle(.purpleDB)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(viewModel.onTheAirSeries){ onAirSeries in
                                NavigationLink(destination: SeriesDetailView(imageName: onAirSeries.fullPosterPath, series: onAirSeries)) {
                                    SeriesCell(movie: onAirSeries, imageURL: onAirSeries.fullPosterPath)
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
    OnTheAirSeriesView()
        .environmentObject(DataBaseViewModel())
}

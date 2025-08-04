//
//  SeriesScrollView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct SeriesScrollView: View {
    @EnvironmentObject var viewModel: SeriesViewModel
    let title: String
    let seriesArray: [SeriesModel]
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack() {
                        Text(title)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: SeriesListView(title: title, seriesArray: seriesArray)
                                .environmentObject(viewModel)
                        ) {
                            Text("View all")
                                .font(.subheadline)
                                .foregroundStyle(.purpleDB)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(seriesArray){ airingToday in
                                NavigationLink(
                                    destination: SeriesDetailView(imageName: airingToday.fullPosterPath, series: airingToday)
                                        .environmentObject(viewModel)
                                ) {
                                    SeriesCell(movie: airingToday, imageURL: airingToday.fullPosterPath)
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
    let seriesArray: [SeriesModel] = [.mock, .mock, .mock, .mock, .mock, .mock]
    
    NavigationStack {
        SeriesScrollView(title: "Airing Today", seriesArray: seriesArray)
            .environmentObject(SeriesViewModel())
    }
}

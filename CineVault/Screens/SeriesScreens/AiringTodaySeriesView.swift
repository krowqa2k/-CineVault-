//
//  LatestSeriesView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct AiringTodaySeriesView: View {
    @EnvironmentObject var viewModel: DataBaseViewModel
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack() {
                        Text("New Episode Today!")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        NavigationLink(destination: AiringTodayListView()) {
                            Text("View all")
                                .font(.subheadline)
                                .foregroundStyle(.purpleDB)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(viewModel.airingToday){ airingToday in
                                NavigationLink(destination: SeriesDetailView(imageName: airingToday.fullPosterPath, series: airingToday)) {
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
    AiringTodaySeriesView()
        .environmentObject(DataBaseViewModel())
}

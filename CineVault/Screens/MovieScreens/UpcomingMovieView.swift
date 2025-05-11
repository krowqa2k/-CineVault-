//
//  UpcomingMovieView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct UpcomingMovieView: View {
    
    @EnvironmentObject var viewModel: MovieDBViewModel
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                HStack() {
                    Text("Upcoming Movies")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    NavigationLink(destination: UpcomingMovieListView()) {
                        Text("View all")
                            .font(.subheadline)
                            .foregroundStyle(.purpleDB)
                    }
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal){
                    LazyHStack {
                        ForEach(viewModel.upcoming){ upcomingMovie in
                            NavigationLink(destination: MovieDetailView(imageName: upcomingMovie.fullPosterPath, movie: upcomingMovie)) {
                                MovieCell(movie: upcomingMovie, imageURL: upcomingMovie.fullPosterPath)
                            }
                        }
                    }
                }
                .frame(maxHeight: 260)
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    UpcomingMovieView()
        .environmentObject(MovieDBViewModel())
}

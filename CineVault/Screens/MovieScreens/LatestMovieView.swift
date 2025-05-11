//
//  LatestMovieView.swift
//  MovieDBApp
//
//  Created by admin on 26/07/2024.
//

import SwiftUI

struct LatestMovieView: View {
    
    var movie: MovieModel = .mock
    var imageURL: String = Constants.mockImage
    
    @EnvironmentObject var viewModel: MovieDBViewModel
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack() {
                        Text("Now Playing")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        NavigationLink(destination: TrendingMovieListView()) {
                            Text("View all")
                                .font(.subheadline)
                                .foregroundStyle(.purpleDB)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(viewModel.trendings.shuffled()){ latestMovie in
                                NavigationLink(destination: MovieDetailView(imageName: latestMovie.fullPosterPath, movie: latestMovie)) {
                                    MovieCell(movie: latestMovie, imageURL: latestMovie.fullPosterPath)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 260)
                    .scrollIndicators(.hidden)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    LatestMovieView()
        .environmentObject(MovieDBViewModel())
}

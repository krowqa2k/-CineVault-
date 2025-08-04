//
//  MoviesSrollView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct MoviesScrollView: View {
    @EnvironmentObject private var viewModel: MoviesViewModel
    let title: String
    let movieArray: [MovieModel]
    
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
                            destination: MoviesListView(movieArray: movieArray)
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
                            ForEach(movieArray){ latestMovie in
                                NavigationLink(
                                    destination: MovieDetailView(imageName: latestMovie.fullPosterPath, movie: latestMovie)
                                        .environmentObject(viewModel)
                                ) {
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
    let movieArray = [MovieModel.mock, MovieModel.mock, MovieModel.mock, MovieModel.mock, MovieModel.mock]
    
    NavigationStack {
        MoviesScrollView(title: "Now Playing!", movieArray: movieArray)
            .environmentObject(MoviesViewModel())
    }
}

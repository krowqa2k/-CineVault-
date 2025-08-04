//
//  MoviesHighlightView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct MoviesHighlightView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    let movieArray: [MovieModel]

    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(movieArray) { movie in
                        NavigationLink(
                            destination: MovieDetailView(imageName: movie.fullPosterPath, movie: movie)
                                .environmentObject(viewModel)
                        ) {
                            MovieHighlightCell(movie: movie, imageURL: movie.fullPosterPath)
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
    let movieArray: [MovieModel] = [MovieModel.mock, MovieModel.mock, MovieModel.mock]
    let webService = WebService()
    
    NavigationStack {
        MoviesHighlightView(movieArray: movieArray)
            .environmentObject(MoviesViewModel(webService: webService))
    }
}

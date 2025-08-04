//
//  MoviesListView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct MoviesListView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    @Environment(\.dismiss) var dismiss
    let title: String
    let movieArray: [MovieModel]
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(spacing: 8) {
                header
                    .padding(.top, 4)
                
                moviesList
                    .padding(.top, 12)
                    .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        HStack {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.purpleDB)
                    .font(.title2)
                    .background(
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.gray.opacity(0.2))
                    )
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 26)
            
            Text(title)
                .foregroundStyle(.purpleDB)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .fixedSize()
            
            Image(systemName: "popcorn.fill")
                .font(.system(size: 25))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
        }
    }
    
    private var moviesList: some View {
        ScrollView {
            ForEach(movieArray){ popularMovie in
                NavigationLink(
                    destination: MovieDetailView(imageName: popularMovie.fullPosterPath, movie: popularMovie)
                        .environmentObject(viewModel)
                ) {
                    MovieListCell(imageName: popularMovie.fullPosterPath, movie: popularMovie)
                        .padding(.top, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
        }
    }
}

#Preview {
    let movieArray: [MovieModel] = [MovieModel.mock, MovieModel.mock, MovieModel.mock]
    let webService = WebService()
    
    NavigationStack {
        MoviesListView(title: "Popular Movies", movieArray: movieArray)
            .environmentObject(MoviesViewModel(webService: webService))
    }
}

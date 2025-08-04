//
//  SearchMovieDetailView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/10/2024.
//

import SwiftUI

struct SearchMovieDetailView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    var imageName: String = Constants.mockImage
    var movie: SearchDBModel = .mock
    @State private var onClick: Bool = false
    @State private var userRating: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                movieImage
                
                userScore
                
                movieDescription
            }
            .overlay(dismissButton, alignment: .topLeading)
            .overlay(favoriteButton, alignment: .topTrailing)
        }
        .onAppear {
            updateOnClickState()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func updateOnClickState() {
        onClick = viewModel.favoriteMoviesAndSeries.contains(movie.fullPosterPath)
    }
    
    private var imageOverlay: some View {
        VStack(alignment: .leading) {
            if let isAdult = movie.adult, isAdult {
                Text("18+")
                    .frame(width: 40, height: 40)
                    .font(.headline)
                    .foregroundStyle(.blackDB)
                    .background(Color.red)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            Text(movie.titleName)
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal)
            
            HStack(alignment: .bottom) {
                Text(movie.releaseYear)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.subheadline)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", movie.voteAverage ?? 0))
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text("(\(movie.voteCount ?? 0) votes)")
                        .font(.footnote)
                        .foregroundStyle(.white)
                }
                .opacity(movie.voteAverage != 0 ? 1 : 0)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movie.genreNames, id: \.self) { genre in
                        Text(genre)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .padding(6)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(.secondary)
                            )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 100)
        .padding(.bottom)
        .background(
            LinearGradient(colors: [Color.blackDB.opacity(0.001), Color.blackDB.opacity(1)], startPoint: .top, endPoint: .bottom)
        )
    }
    
    private var movieImage: some View {
        ImageLoader(imageURL: imageName)
            .ignoresSafeArea(edges: .top)
            .frame(height: UIScreen.main.bounds.height / 1.7, alignment: .top)
            .overlay(imageOverlay, alignment: .bottom)
    }
    
    private var userScore: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Score:")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white.secondary)
            
            HStack {
                ForEach(1...10, id: \.self) { star in
                    Image(systemName: star <= userRating ? "star.fill" : "star")
                        .font(.title2)
                        .foregroundStyle(LinearGradient(colors: [.white, .yellow, .orange], startPoint: .topTrailing, endPoint: .bottomLeading))
                        .onTapGesture {
                            userRating = star
                        }
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
    
    private var movieDescription: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(movie.overview ?? "No data :(")
                .font(.title3)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }
    
    private var dismissButton: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundStyle(.blackDB.opacity(0.8))
            .overlay(
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
            )
            .padding()
            .onTapGesture {
                dismiss()
            }
    }
    
    private var favoriteButton: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundStyle(.blackDB.opacity(0.8))
            .overlay(
                Image(systemName: "heart.fill")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(onClick ? .red : .white)
            )
            .padding()
            .onTapGesture {
                toggleFavorite()
            }
    }
    
    private func toggleFavorite() {
        if viewModel.favoriteMoviesAndSeries.contains(movie.fullPosterPath) {
            viewModel.favoriteMoviesAndSeries.remove(movie.fullPosterPath)
            viewModel.removeFavorite(posterPath: movie.fullPosterPath)
        } else {
            viewModel.favoriteMoviesAndSeries.insert(movie.fullPosterPath)
            viewModel.addFavorite(posterPath: movie.fullPosterPath)
        }
        onClick.toggle()
    }
}

#Preview {
    let webService = WebService()
    
    SearchMovieDetailView()
        .environmentObject(SearchViewModel(webService: WebService()))
}




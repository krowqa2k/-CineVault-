//
//  SearchMovieDetailScreen.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import SwiftUI

struct SearchMovieDetailScreen: View {
    
    @EnvironmentObject var viewModel: DataBaseViewModel
    var imageName: String = Constants.mockImage
    var movie: SearchDBModel = .mock
    @State private var onClick: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                ImageLoader(imageURL: imageName).ignoresSafeArea(edges: .top)
                    .frame(height: UIScreen.main.bounds.height / 1.7, alignment: .top)
                    .overlay (
                        VStack(alignment: .leading) {
                            HStack {
                                Text(movie.adult ?? false ? "18+" : "")
                                    .frame(width: 40, height: 40)
                                    .font(.headline)
                                    .foregroundStyle(.blackDB)
                                    .background(movie.adult ?? false ? Color.red : .clear)
                                    .cornerRadius(12)
                                Spacer()
                                HStack {
                                    Image(systemName: "star.fill")
                                        .font(.headline)
                                        .foregroundStyle(.yellow)
                                    Text(String(format: "%.2f", movie.voteAverage ?? "No Data :("))
                                        .font(.headline)
                                        .foregroundStyle(.yellow)
                                }
                                .padding(4)
                                .background(Color.blackDB)
                                .cornerRadius(12)
                            }
                            .padding(.horizontal)
                            
                            Text(movie.title ?? movie.name ?? "")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            Text("Release Date: \(movie.releaseDate ?? movie.firstAirDate ?? "No data :(")")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                                .padding(.horizontal)
                        }
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: 100)
                            .padding(.bottom)
                            .background(
                                LinearGradient(colors: [Color.blackDB.opacity(0.001), Color.blackDB.opacity(1)], startPoint: .top, endPoint: .bottom)
                            )
                        ,alignment: .bottom
                    )
                ScrollView(.vertical){
                    Text(movie.overview ?? "No data :(")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                }
            }
            .overlay(
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
                    },alignment: .topLeading
            )
            .overlay(
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
                        if viewModel.favoriteMoviesAndSeries.contains(movie.fullPosterPath){
                            viewModel.favoriteMoviesAndSeries.remove(movie.fullPosterPath)
                            viewModel.removeFavorite(posterPath: movie.fullPosterPath)
                        } else {
                            viewModel.favoriteMoviesAndSeries.insert(movie.fullPosterPath)
                            viewModel.addFavorite(posterPath: movie.fullPosterPath)
                        }
                        onClick.toggle()
                    },alignment: .topTrailing
            )
        }
        .onAppear(perform: {
            updateOnClickState()
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    private func updateOnClickState() {
        onClick = viewModel.favoriteMoviesAndSeries.contains(movie.fullPosterPath)
    }
}

#Preview {
    SearchMovieDetailScreen()
        .environmentObject(DataBaseViewModel())
}

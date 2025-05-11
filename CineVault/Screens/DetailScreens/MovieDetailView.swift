//
//  PopularMovieDetailView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI
import SwiftData

struct MovieDetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var viewModel: MovieDBViewModel
    var imageName: String = Constants.mockImage
    var movie: MovieModel = .mock
    @State private var onClick: Bool = false
    @State private var userRating: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                movieImage
                
                if movie.voteAverage != 0 {
                    userScore
                }
                
                movieDescription
            }
            .overlay(dismissScreen, alignment: .topLeading)
            .overlay(favoriteButton, alignment: .topTrailing)
        }
        .onAppear(perform: {
            updateOnClickState()
            fetchUserRating()
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func fetchUserRating() {
        let fetchDescriptor = FetchDescriptor<UserRatingModel>(sortBy: [])
        
        do {
            let ratings = try modelContext.fetch(fetchDescriptor)
            if let existingRating = ratings.first(where: { $0.title == movie.title }) {
                userRating = existingRating.rating
            }
        } catch {
            print("Error fetching user ratings: \(error.localizedDescription)")
        }
    }
    
    private func saveUserRating() {
        let fetchDescriptor = FetchDescriptor<UserRatingModel>(
            predicate: #Predicate { $0.title == movie.title },
            sortBy: []
        )
        
        do {
            let ratings = try modelContext.fetch(fetchDescriptor)
            
            if let existingRating = ratings.first {
                existingRating.rating = userRating
            } else {
                let newRating = UserRatingModel(title: movie.title, imageName: imageName, rating: userRating)
                modelContext.insert(newRating)
            }
            
            try modelContext.save()
            
        } catch {
            print("Error saving user rating: \(error.localizedDescription)")
        }
    }

    private func updateOnClickState() {
        onClick = viewModel.favoriteMoviesAndSeries.contains(movie.fullPosterPath)
    }
    
    private var imageOverlay: some View {
        VStack(alignment: .leading) {
            Text(movie.adult ? "18+" : "")
                .frame(width: 40, height: 40)
                .font(.headline)
                .foregroundStyle(.blackDB)
                .background(movie.adult ? Color.red : .clear)
                .cornerRadius(12)
                .padding(.horizontal)
            
            Text(movie.title)
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal)
            HStack(alignment: .bottom) {
                Text("\(movie.releaseYear)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.subheadline)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", movie.voteAverage))
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text("(\(movie.voteCount.formatted()) votes)")
                        .foregroundStyle(.white)
                        .font(.footnote)
                    Spacer()
                }
                .opacity(movie.voteAverage != 0 ? 1:0)
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
        ImageLoader(imageURL: imageName).ignoresSafeArea(edges: .top)
            .frame(height: UIScreen.main.bounds.height / 1.7, alignment: .top)
            .overlay (imageOverlay ,alignment: .bottom)
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
                        .foregroundStyle(LinearGradient(colors: [.white,.yellow,.orange], startPoint: .topTrailing, endPoint: .bottomLeading))
                        .onTapGesture {
                            userRating = star
                            saveUserRating()
                        }
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
    
    private var movieDescription: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(movie.overview)
                .font(.title3)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }
    
    private var dismissScreen: some View {
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
                if viewModel.favoriteMoviesAndSeries.contains(movie.fullPosterPath){
                    viewModel.favoriteMoviesAndSeries.remove(movie.fullPosterPath)
                    viewModel.removeFavorite(posterPath: movie.fullPosterPath)
                } else {
                    viewModel.favoriteMoviesAndSeries.insert(movie.fullPosterPath)
                    viewModel.addFavorite(posterPath: movie.fullPosterPath)
                }
                onClick.toggle()
            }
    }
}

#Preview {
    ZStack {
        Color.blackDB
        MovieDetailView()
            .environmentObject(MovieDBViewModel())
    }
}

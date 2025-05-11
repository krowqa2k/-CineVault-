//
//  PopularSeriesDetailView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI
import SwiftData

struct SeriesDetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var viewModel: DataBaseViewModel
    var imageName: String = Constants.mockImage
    var series: SeriesModel = .mock
    @State private var onClick: Bool = false
    @State private var userRating: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                seriesImage
                    .overlay(imageOverlay, alignment: .bottom)
                
                if (series.voteAverage != nil) {
                    userScore
                        .padding(.bottom)
                }

                ScrollView(.vertical){
                    Text(series.overview ?? "")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                }
            }
            .overlay(dismissButton, alignment: .topLeading)
            .overlay(addToFavoritesButton, alignment: .topTrailing)
        }
        .onAppear(perform: {
            updateOnClickState()
            fetchUserRating()
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    private func updateOnClickState() {
        onClick = viewModel.favoriteMoviesAndSeries.contains(series.fullPosterPath)
    }
    
    private var imageOverlay: some View {
        VStack(alignment: .leading) {
            Text(series.adult ?? false ? "18+" : "")
                .frame(width: 40, height: 40)
                .font(.headline)
                .foregroundStyle(.blackDB)
                .background(series.adult ?? false ? Color.red : .clear)
                .cornerRadius(12)
                .padding(.horizontal)
            
            Text(series.name)
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal)
            HStack(alignment: .bottom) {
                Text("\(series.firstAirYear)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.subheadline)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", series.voteAverage ?? 0))
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text("(\(series.voteCount ?? 0) votes)")
                        .foregroundStyle(.white)
                        .font(.footnote)
                    Spacer()
                }
                .opacity(series.voteAverage != 0 ? 1:0)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(series.genreNames, id: \.self) { genre in
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
    
    private var addToFavoritesButton: some View {
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
                if viewModel.favoriteMoviesAndSeries.contains(series.fullPosterPath){
                    viewModel.favoriteMoviesAndSeries.remove(series.fullPosterPath)
                    viewModel.removeFavorite(posterPath: series.fullPosterPath)
                } else {
                    viewModel.favoriteMoviesAndSeries.insert(series.fullPosterPath)
                    viewModel.addFavorite(posterPath: series.fullPosterPath)
                }
                onClick.toggle()
            }
    }
    
    private func fetchUserRating() {
        let fetchDescriptor = FetchDescriptor<UserRatingModel>(sortBy: [])
        
        do {
            let ratings = try modelContext.fetch(fetchDescriptor)
            if let existingRating = ratings.first(where: { $0.title == series.name }) {
                userRating = existingRating.rating
            }
        } catch {
            print("Error fetching user ratings: \(error.localizedDescription)")
        }
    }
    
    private func saveUserRating() {
        let fetchDescriptor = FetchDescriptor<UserRatingModel>(
            predicate: #Predicate { $0.title == series.name },
            sortBy: []
        )
        
        do {
            let ratings = try modelContext.fetch(fetchDescriptor)
            
            if let existingRating = ratings.first {
                existingRating.rating = userRating
            } else {
                let newRating = UserRatingModel(title: series.name, imageName: imageName, rating: userRating)
                modelContext.insert(newRating)
            }
            
            try modelContext.save()
            
        } catch {
            print("Error saving user rating: \(error.localizedDescription)")
        }
    }
    
    private var seriesImage: some View {
        ImageLoader(imageURL: imageName).ignoresSafeArea(edges: .top)
            .frame(height: UIScreen.main.bounds.height / 1.7, alignment: .top)
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
}

#Preview {
    SeriesDetailView()
        .environmentObject(DataBaseViewModel())
}

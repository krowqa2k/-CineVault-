//
//  MoviesViewModel.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import Foundation
import SwiftUI

@MainActor
final class MoviesViewModel: ObservableObject {
    @Published private(set) var trendings: [MovieModel] = []
    @Published private(set) var popular: [MovieModel] = []
    @Published private(set) var upcoming: [MovieModel] = []
    @Published private(set) var topRated: [MovieModel] = []
    
    private let favoritesManager = FavoritesService.shared
    private let webService: WebServiceProtocol
    
    @Published var currentIndex = 0
    @Published var timer: Timer?
    
    // Favorites
    @Published var favoriteMoviesAndSeries: Set<String> {
        didSet {
            favoritesManager.favoriteMoviesAndSeries = favoriteMoviesAndSeries
        }
    }
    
    init(webService: WebServiceProtocol) {
        self.favoriteMoviesAndSeries = favoritesManager.favoriteMoviesAndSeries
        self.webService = webService
        Task {
            await fetchAllData()
        }
    }
    
    private func fetchAllData() async {
        await withTaskGroup { group in
            group.addTask {
                await self.getTrendingsData()
            }
            
            group.addTask {
                await self.getPopularData()
            }
            
            group.addTask {
                await self.getUpcomingData()
            }
            
            group.addTask {
                await self.getTopRatedData()
            }
        }
    }

    func addFavorite(posterPath: String) {
        favoriteMoviesAndSeries.insert(posterPath)
    }

    func removeFavorite(posterPath: String) {
        favoriteMoviesAndSeries.remove(posterPath)
    }
    
    private func sortUpcomingMoviesByDate() {
        upcoming.sort { $1.releaseDate > $0.releaseDate }
    }
    
    private func sortTopRatedMoviesByRating() {
        topRated.sort { $0.voteAverage > $1.voteAverage }
    }
    
    func getYear(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        } else {
            return ""
        }
    }
    
    private func getTrendingsData() async {
        do {
            let result: MovieResults = try await webService.getTrendingsData()
            self.trendings = result.results
        } catch {
            print("Error fetching trendings: \(error)")
        }
    }
    
    private func getPopularData() async {
        do {
            let result: MovieResults = try await webService.getPopularData()
            self.popular = result.results
        } catch {
            print("Error fetching popular movies: \(error)")
        }
    }
    
    private func getUpcomingData() async {
        do {
            let result: MovieResults = try await webService.getUpcomingData()
            self.upcoming = result.results
            sortUpcomingMoviesByDate()
        } catch {
            print("Error fetching upcoming movies: \(error)")
        }
    }
    
    private func getTopRatedData() async {
        do {
            let result: MovieResults = try await webService.getTopRatedData()
            self.topRated = result.results
            sortTopRatedMoviesByRating()
        } catch {
            print("Error fetching top-rated movies: \(error)")
        }
    }
}

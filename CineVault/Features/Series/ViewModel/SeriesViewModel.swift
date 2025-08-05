//
//  SeriesViewModel.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import Foundation

@MainActor
final class SeriesViewModel: ObservableObject {
    @Published private(set) var airingToday: [SeriesModel] = []
    @Published private(set) var popularSeries: [SeriesModel] = []
    @Published private(set) var onTheAirSeries: [SeriesModel] = []
    @Published private(set) var topRatedSeries: [SeriesModel] = []
    
    private let favoritesManager = FavoritesService.shared
    private let webService: WebServiceProtocol
    
    @Published var isLoading: Bool = false
    @Published var initialDataFetched: Bool = false
    
    // Favorites
    @Published var favoriteMoviesAndSeries: Set<String> {
        didSet {
            favoritesManager.favoriteMoviesAndSeries = favoriteMoviesAndSeries
        }
    }
    
    init(webService: WebServiceProtocol) {
        self.favoriteMoviesAndSeries = favoritesManager.favoriteMoviesAndSeries
        self.webService = webService
    }
    
    func fetchInitialData() async {
        isLoading = true
        await withTaskGroup { group in
            group.addTask {
                await self.getAiringTodayData()
            }
            
            group.addTask {
                await self.getPopularSeriesData()
            }
            
            group.addTask {
                await self.getTopRatedSeriesData()
            }
            
            group.addTask {
                await self.getOnTheAirSeriesData()
            }
        }
        isLoading = false
        initialDataFetched = true
    }
    
    func refreshFetchData() async {
        guard !isLoading, !initialDataFetched else { return }
        await fetchInitialData()
    }
    
    func addFavorite(posterPath: String) {
        favoriteMoviesAndSeries.insert(posterPath)
    }

    func removeFavorite(posterPath: String) {
        favoriteMoviesAndSeries.remove(posterPath)
    }
    
    private func sortTopRatedSeriesByRating() {
        topRatedSeries.sort { $0.voteAverage ?? 0 > $1.voteAverage ?? 0 }
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
    
    private func getAiringTodayData() async {
        do {
            let result: SeriesResults = try await webService.getAiringTodayData()
            self.airingToday = result.results
        } catch {
            print("Error fetching airing today series: \(error)")
        }
    }
    
    private func getPopularSeriesData() async {
        do {
            let result: SeriesResults = try await webService.getTrendingSeriesData()
            self.popularSeries = result.results
        } catch {
            print("Error fetching popular series: \(error)")
        }
    }
    
    private func getTopRatedSeriesData() async {
        do {
            let result: SeriesResults = try await webService.getTopRatedSeriesData()
            self.topRatedSeries = result.results
            sortTopRatedSeriesByRating()
        } catch {
            print("Error fetching top-rated series: \(error)")
        }
    }
    
    private func getOnTheAirSeriesData() async {
        do {
            let result: SeriesResults = try await webService.getOnTheAirSeriesData()
            self.onTheAirSeries = result.results
        } catch {
            print("Error fetching on-the-air series: \(error)")
        }
    }
}

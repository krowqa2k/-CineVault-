//
//  SearchViewModel.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchDB: [SearchDBModel] = []
    
    private let favoritesManager = FavoritesService.shared
    private let webService: WebServiceProtocol
    
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
    
    func getSearchDBData(query: String) async {
        do {
            let result: SearchDBResults = try await webService.getSearchDBData(query: query)
            self.searchDB = result.results
        } catch {
            print("Error fetching search results: \(error)")
        }
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
    
    func addFavorite(posterPath: String) {
        favoriteMoviesAndSeries.insert(posterPath)
    }

    func removeFavorite(posterPath: String) {
        favoriteMoviesAndSeries.remove(posterPath)
    }
}

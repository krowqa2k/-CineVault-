//
//  FavoriteDataManager.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 04/08/2024.
//

import Foundation

class FavoritesService {
    
    private let favoritesKey = "favoritesKey"
    
    var favoriteMoviesAndSeries: Set<String> {
        get {
            let savedFavorites = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
            return Set(savedFavorites)
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: favoritesKey)
        }
    }
    
    func addFavorite(id: String) {
        var favorites = favoriteMoviesAndSeries
        favorites.insert(id)
        favoriteMoviesAndSeries = favorites
    }
    
    func removeFavorite(id: String) {
        var favorites = favoriteMoviesAndSeries
        favorites.remove(id)
        favoriteMoviesAndSeries = favorites
    }
}

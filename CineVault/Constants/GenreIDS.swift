//
//  GenreIDS.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 18/11/2024.
//

import Foundation

enum Genre: Int {
    case action = 28
    case actionAdventure = 10759
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    case talk = 10767
    case scifiFantasy = 10765
    case soap = 10766
    case news = 10763
    case reality = 110764
    case warPolitics = 10768
    
    var genreName: String {
        switch self {
        case .action:
            return "Action"
        case .actionAdventure:
            return "Action Adventure"
        case .adventure:
            return "Adventure"
        case .animation:
            return "Animation"
        case .comedy:
            return "Comedy"
        case .crime:
            return "Crime"
        case .documentary:
            return "Documentary"
        case .drama:
            return "Drama"
        case .family:
            return "Family"
        case .fantasy:
            return "Fantasy"
        case .history:
            return "History"
        case .horror:
            return "Horror"
        case .music:
            return "Music"
        case .mystery:
            return "Mystery"
        case .romance:
            return "Romance"
        case .scienceFiction:
            return "Science Fiction"
        case .tvMovie:
            return "TV Movie"
        case .thriller:
            return "Thriller"
        case .war:
            return "War"
        case .western:
            return "Western"
        case .talk:
            return "Talk"
        case .scifiFantasy:
            return "SciFi Fantasy"
        case .soap:
            return "Soap"
        case .news:
            return "News"
        case .reality:
            return "Reality"
        case .warPolitics:
            return "War Politics"
        }
    }
}

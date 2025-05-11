//
//  SearchDBModel.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import Foundation

struct SearchDBResults: Codable {
    let page: Int
    let results: [SearchDBModel]
}

struct SearchDBModel: Codable, Identifiable {
    let adult: Bool?
    let id: Int
    let genreIDS: [Int]?
    let title: String?
    let overview: String?
    let posterPath: String?
    let popularity: Double?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let firstAirDate: String?
    let profilePath: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case id, title
        case genreIDS = "genre_ids"
        case overview
        case posterPath = "poster_path"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case profilePath = "profile_path"
        case name
    }
    
    var fullPosterPath: String {
        if let posterPath = posterPath {
            Constants.imageGet + posterPath
        } else if let profilePath = profilePath {
            Constants.imageGet + profilePath
        } else {
            Constants.noImage
        }
    }
    
    var titleName: String {
        if let title = title {
            return title
        } else if let name = name {
            return name
        } else {
            return "Unknown Title"
        }
    }
    
    var releaseYear: String {
        releaseDate?.extractYearFromDate() ?? firstAirDate?.extractYearFromDate() ?? "N/A"
    }
    
    var genreNames: [String] {
        guard let genreIDS = genreIDS, !genreIDS.isEmpty else { return ["N/A"] }
        return genreIDS.map { Genre(rawValue: $0)?.genreName ?? "N/A" }
    }
    
    static var mock: SearchDBModel {
        SearchDBModel(
            adult: true,
            id: 1234,
            genreIDS: [28],
            title: "The Dark Knight",
            overview: "opis filmu o batmanie",
            posterPath: Constants.mockImage,
            popularity: 241225,
            releaseDate: "2008/09/10",
            voteAverage: 8.7,
            voteCount: 25215,
            firstAirDate: "2008/09/10",
            profilePath: Constants.mockImage,
            name: "The Dark Knight"
        )
    }
}


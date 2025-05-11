//
//  PopularActorsModel.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import Foundation

struct ActorResults: Codable {
    let page: Int
    let results: [ActorModel]
}

struct ActorModel: Codable, Identifiable {
    let adult: Bool
    let gender, id: Int
    let name, originalName: String
    let popularity: Double
    let profilePath: String
    let knownFor: [KnownForModel]?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
    
    var fullPosterPath: String {
            Constants.imageGet + profilePath
    }
    
    static var mock: ActorModel {
        ActorModel(
            adult: false,
            gender: 2,
            id: 64,
            name: "Gary Oldman",
            originalName: "Gary Oldman",
            popularity: 221.628,
            profilePath: "/2v9FVVBUrrkW2m3QOcYkuhq9A6o.jpg",
            knownFor: [KnownForModel(
                id: 155,
                title: "The Dark Knight",
                originalTitle: "The Dark Knight",
                overview: "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.",
                posterPath: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
                adult: false,
                popularity: 168.441,
                releaseDate: "2008-07-16",
                voteAverage: 8.516
            )]
        )
    }
}

struct KnownForModel: Codable, Identifiable {
    let id: Int
    let title, originalTitle: String?
    let overview, posterPath: String?
    let adult: Bool
    let popularity: Double
    let releaseDate: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case adult
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    var fullPosterPath: String {
        guard let posterPath = posterPath else { return Constants.noImage }
        return Constants.imageGet + posterPath
    }
    
    static var mock: KnownForModel {
        KnownForModel(
            id: 155,
            title: "The Dark Knight",
            originalTitle: "The Dark Knight",
            overview: "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.",
            posterPath: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            adult: false,
            popularity: 168.441,
            releaseDate: "2008-07-16",
            voteAverage: 8.516
        )
    }
}



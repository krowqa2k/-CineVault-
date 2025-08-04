//
//  TopRatedMovieModel.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import Foundation

struct MovieResults: Codable {
    let page: Int
    let results: [MovieModel]
}

struct MovieModel: Codable, Identifiable {
    let adult: Bool
    let id: Int
    let genreIDS: [Int]
    let originalLanguage, originalTitle, overview: String
    let posterPath: String?
    let releaseDate, title: String
    let voteAverage: Double
    let voteCount: Double

    var fullPosterPath: String {
        guard let posterPath = posterPath else { return Constants.noImage }
        return Constants.imageGet + posterPath
    }
    
    var releaseYear: String {
        releaseDate.extractYearFromDate() ?? "N/A"
    }
    
    var genreNames: [String] {
        genreIDS.map { Genre(rawValue: $0)?.genreName ?? "N/A"}
    }
    
    static var mock: MovieModel {
        MovieModel(
            adult: false,
            id: 278,
            genreIDS: [878,28,12],
            originalLanguage: "en",
            originalTitle: "The Shawshank Redemption",
            overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
            posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
            releaseDate: "1994-09-23",
            title: "The Shawshank Redemption",
            voteAverage: 8.706,
            voteCount: 26526
        )
    }
}

private extension MovieModel {
    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

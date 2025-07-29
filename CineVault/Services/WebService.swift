//
//  WebService.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 08/08/2024.
//

import Foundation

final class WebService {
    private let apiKey: String = "5c7cea308def9c5b381b8e963b9df62a"
    
    private let baseURL: String = "https://api.themoviedb.org/3/"
    private let baseURLMovie: String = "https://api.themoviedb.org/3/movie/"
    private let baseURLSeries: String = "https://api.themoviedb.org/3/tv/"
    private let baseURLSearch: String = "https://api.themoviedb.org/3/search/multi?api_key="
    
    private func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ErrorCases.requestFailed
        }
        
        do {
            let decoder = JSONDecoder()
            
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw ErrorCases.decodingError
        }
    }
    
    func getTrendingsData() async throws -> MovieResults {
        guard let url = URL(string: "\(baseURLMovie)now_playing?api_key=\(apiKey)") else {
            throw ErrorCases.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getPopularData() async throws -> MovieResults {
        guard let url = URL(string: "\(baseURLMovie)popular?api_key=\(apiKey)") else {
            throw ErrorCases.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getUpcomingData() async throws -> MovieResults {
        guard let url = URL(string: "\(baseURLMovie)upcoming?language=en-US&page=1&region=pl&api_key=\(apiKey)") else {
            throw ErrorCases.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getTopRatedData() async throws -> MovieResults {
        guard let url = URL(string: "\(baseURLMovie)top_rated?api_key=\(apiKey)") else {
            throw ErrorCases.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getAiringTodayData() async throws -> SeriesResults {
        guard let url = URL(string: "\(baseURLSeries)airing_today?api_key=\(apiKey)") else {
            throw ErrorCases.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getTrendingSeriesData() async throws -> SeriesResults {
        guard let url = URL(string: "\(baseURL)trending/tv/day?api_key=\(apiKey)") else {
            throw ErrorCases.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getTopRatedSeriesData() async throws -> SeriesResults {
        guard let url = URL(string: "\(baseURLSeries)top_rated?api_key=\(apiKey)") else {
            throw ErrorCases.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getOnTheAirSeriesData() async throws -> SeriesResults {
        guard let url = URL(string: "\(baseURLSeries)on_the_air?api_key=\(apiKey)") else {
            throw ErrorCases.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getSearchDBData(query: String) async throws -> SearchDBResults {
        guard !query.isEmpty else {
            throw ErrorCases.invalidURL
        }
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURLSearch)\(apiKey)&query=\(queryEncoded)"
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidURL
        }
        return try await fetch(url: url)
    }
}


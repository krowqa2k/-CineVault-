//
//  WebService.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 08/08/2024.
//

import Foundation

final class WebService {
    static let apiKey = "5c7cea308def9c5b381b8e963b9df62a"
    
    enum WebServiceError: Error {
        case invalidURL
        case requestFailed
        case decodingError
    }
    
    private func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw WebServiceError.requestFailed
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw WebServiceError.decodingError
        }
    }
    
    func getTrendingsData() async throws -> MovieResults {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(Self.apiKey)") else {
            throw WebServiceError.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getPopularData() async throws -> MovieResults {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(Self.apiKey)") else {
            throw WebServiceError.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getUpcomingData() async throws -> MovieResults {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&region=pl&api_key=\(Self.apiKey)") else {
            throw WebServiceError.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getTopRatedData() async throws -> MovieResults {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(Self.apiKey)") else {
            throw WebServiceError.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getPopularActorData() async throws -> ActorResults {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/popular?api_key=\(Self.apiKey)") else {
            throw WebServiceError.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getAiringTodayData() async throws -> SeriesResults {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/airing_today?api_key=\(Self.apiKey)") else {
            throw WebServiceError.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getPopularSeriesData() async throws -> SeriesResults {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/tv/day?api_key=\(Self.apiKey)") else {
            throw WebServiceError.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getTopRatedSeriesData() async throws -> SeriesResults {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=\(Self.apiKey)") else {
            throw WebServiceError.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getOnTheAirSeriesData() async throws -> SeriesResults {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(Self.apiKey)") else {
            throw WebServiceError.invalidURL
        }
        return try await fetch(url: url)
    }
    
    func getSearchDBData(query: String) async throws -> SearchDBResults {
            guard !query.isEmpty else {
                throw WebServiceError.invalidURL
            }
            let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlString = "https://api.themoviedb.org/3/search/multi?api_key=\(Self.apiKey)&query=\(queryEncoded)"
            guard let url = URL(string: urlString) else {
                throw WebServiceError.invalidURL
            }
            return try await fetch(url: url)
    }
}


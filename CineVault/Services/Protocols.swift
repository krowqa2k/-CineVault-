//
//  Protocols.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import Foundation

protocol WebServiceProtocol {
    func getTrendingsData() async throws -> MovieResults
    func getPopularData() async throws -> MovieResults
    func getUpcomingData() async throws -> MovieResults
    func getTopRatedData() async throws -> MovieResults
    func getAiringTodayData() async throws -> SeriesResults
    func getTrendingSeriesData() async throws -> SeriesResults
    func getTopRatedSeriesData() async throws -> SeriesResults
    func getOnTheAirSeriesData() async throws -> SeriesResults
    func getSearchDBData(query: String) async throws -> SearchDBResults
}

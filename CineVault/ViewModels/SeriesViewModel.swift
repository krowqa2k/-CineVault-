//
//  SeriesViewModel.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/10/2024.
//

import Foundation

@MainActor
final class SeriesViewModel: ObservableObject {
    @Published private(set) var airingToday: [SeriesModel] = []
    @Published private(set) var popularSeries: [SeriesModel] = []
    @Published private(set) var onTheAirSeries: [SeriesModel] = []
    @Published private(set) var topRatedSeries: [SeriesModel] = []
    
    private let webService = WebService()
}

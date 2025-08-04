//
//  MainViewViewModel.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import Foundation

final class MainViewViewModel: ObservableObject {
    @Published var index: Int = 0
    @Published var loadingState: LoadingState = .loading
    @Published var viewOption: ViewSelection = .movies
}

enum LoadingState {
    case loading
    case loaded
}

enum ViewSelection: String, CaseIterable {
    case movies
    case series
    
    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .series:
            return "Series"
        }
    }
}

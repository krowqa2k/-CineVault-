//
//  MovieDBAppApp.swift
//  MovieDBApp
//
//  Created by admin on 25/07/2024.
//

import SwiftData
import SwiftUI

@main
struct CineVault: App {
    private let webService: WebServiceProtocol = WebService()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainView(index: 0, webService: webService)
            }
            .modelContainer(for: UserRatingModel.self)
        }
    }
}

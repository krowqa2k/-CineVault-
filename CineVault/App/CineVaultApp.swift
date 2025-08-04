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
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainView(index: 0)
            }
            .modelContainer(for: UserRatingModel.self)
        }
    }
}

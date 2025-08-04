//
//  UserRatingModel.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 15/11/2024.
//

import Foundation
import SwiftData

@Model
final class UserRatingModel {
    var title: String
    var imageName: String
    var rating: Int
    
    init(title: String, imageName: String, rating: Int) {
        self.title = title
        self.imageName = imageName
        self.rating = rating
    }
}

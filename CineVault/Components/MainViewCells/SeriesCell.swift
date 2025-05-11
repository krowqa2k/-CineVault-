//
//  AiringTodaySeriesCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct SeriesCell: View {
    var movie: SeriesModel = .mock
    var imageURL: String = Constants.mockImage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ImageLoader(imageURL: imageURL)
                .frame(width: 160, height: 220)
                .cornerRadius(16)
            
            Text(movie.name)
                .foregroundStyle(.white)
                .font(.caption)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(width: 160)
        }
        .padding(.leading, 8)
    }
}

#Preview {
    ZStack {
        Color.blackDB.ignoresSafeArea()
        SeriesCell()
    }
}

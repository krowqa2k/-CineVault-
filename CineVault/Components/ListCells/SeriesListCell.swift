//
//  AiringTodayListCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct SeriesListCell: View {
    var imageName: String = Constants.mockImage
    var series: SeriesModel = .mock
    
    var body: some View {
        HStack(spacing: 12) {
            ImageLoader(imageURL: imageName)
                .frame(width: 110, height: 160)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 8){
                Text(series.name)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                Text(series.firstAirYear)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                Text(series.genreNames[0])
                    .font(.subheadline)
                    .foregroundStyle(.gray)

                if let adult = series.adult {
                    if adult {
                        Text("For adults")
                            .font(.system(size: 13))
                            .foregroundStyle(.red)
                    }
                }
                HStack {
                    Image(systemName: "star.fill")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", series.voteAverage ?? 0))
                        .font(.headline)
                        .foregroundStyle(.yellow)
                }
            }
            .frame(maxHeight: 150, alignment: .top)
        }
    }
}

#Preview {
    ZStack {
        Color.blackDB.ignoresSafeArea()
        SeriesListCell()
    }
}

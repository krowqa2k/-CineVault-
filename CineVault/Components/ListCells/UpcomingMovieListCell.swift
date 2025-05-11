//
//  UpcomingMovieListCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct UpcomingMovieListCell: View {
    var imageName: String = Constants.mockImage
    var movie: MovieModel = .mock
    
    var body: some View {
        HStack(spacing: 12) {
            ImageLoader(imageURL: imageName)
                .frame(width: 110, height: 160)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 8){
                Text(movie.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                Text(movie.genreNames[0])
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Text("Release date: \(movie.releaseDate)")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
            .frame(maxHeight: 150, alignment: .top)
        }
    }
}

#Preview {
    UpcomingMovieListCell()
}

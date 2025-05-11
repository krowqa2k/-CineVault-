//
//  LatestMovieListCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct MovieListCell: View {
    
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
                Text(movie.releaseYear)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                
                Text(movie.genreNames[0])
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", movie.voteAverage))
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
        MovieListCell()
    }
}

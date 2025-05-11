//
//  UpcomingMovieDetailView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct UpcomingMovieDetailView: View {
    var imageName: String = Constants.mockImage
    var movie: MovieModel = .mock
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                ImageLoader(imageURL: imageName).ignoresSafeArea(edges: .top)
                    .frame(height: UIScreen.main.bounds.height / 1.7, alignment: .top)
                    .overlay (
                        VStack(alignment: .leading) {
                            HStack {
                                Text(movie.adult ? "18+" : "")
                                    .frame(width: 40, height: 40)
                                    .font(.headline)
                                    .foregroundStyle(.blackDB)
                                    .background(movie.adult ? Color.red : .clear)
                                    .cornerRadius(12)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Text(movie.title)
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            Text("Release Date: \(movie.releaseDate)")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                                .padding(.horizontal)
                        }
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: 100)
                            .padding(.bottom)
                            .background(
                                LinearGradient(colors: [Color.blackDB.opacity(0.001), Color.blackDB.opacity(1)], startPoint: .top, endPoint: .bottom)
                            )
                        ,alignment: .bottom
                    )
                ScrollView(.vertical){
                    Text(movie.overview)
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                }
            }
            .overlay(
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.blackDB.opacity(0.8))
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                    )
                    .padding()
                    .onTapGesture {
                        dismiss()
                    },alignment: .topLeading
            )
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    UpcomingMovieDetailView()
}

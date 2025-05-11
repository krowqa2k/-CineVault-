//
//  UpcomingMovieListView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct UpcomingMovieListView: View {
    
    @EnvironmentObject var viewModel: DataBaseViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(spacing: 8) {
                header
                    .padding(.top, 4)
                
                moviesList
                    .padding(.top, 12)
                    .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        HStack {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.purpleDB)
                    .font(.title2)
                    .background(
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.gray.opacity(0.2))
                    )
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 26)
            Text("Upcoming")
                .foregroundStyle(.purpleDB)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Image(systemName: "popcorn.fill")
                .font(.system(size: 25))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
        }
    }
    
    private var moviesList: some View {
        ScrollView {
            ForEach(viewModel.upcoming){ upcomingMovie in
                NavigationLink(destination: MovieDetailView(imageName: upcomingMovie.fullPosterPath, movie: upcomingMovie)) {
                    UpcomingMovieListCell(imageName: upcomingMovie.fullPosterPath, movie: upcomingMovie)
                        .padding(.top, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
        }
    }
}

#Preview {
    UpcomingMovieListView()
        .environmentObject(DataBaseViewModel())
}

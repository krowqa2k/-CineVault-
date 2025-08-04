//
//  SearchView .swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    @State private var query: String = ""
    
    init(webService: WebServiceProtocol) {
        _viewModel = StateObject(wrappedValue: SearchViewModel(webService: webService))
    }
        
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(spacing: 8) {
                header
                searchBar
                    .padding(.top)
                Spacer()
                if !query.isEmpty {
                    moviesResult
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private var header: some View {
        HStack {
            Text("Search")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Color.purpleDB)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Image(systemName: "popcorn.fill")
                .font(.system(size: 25))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
        }
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundStyle(.purpleDB)
                .padding(.leading)
                .padding(.trailing, 0)
            TextField("Search Movies, TV Series...", text: $query) {
                Task {
                    await viewModel.getSearchDBData(query:query)
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.trailing,12)
            .padding(.leading, 0)
            .frame(maxWidth: .infinity)
            .tint(.purpleDB)
            
            if !query.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .padding(.trailing,12)
                    .foregroundStyle(.white)
                    .background(Color.blackDB.opacity(0.01))
                    .onTapGesture {
                        query = ""
                        viewModel.searchDB.removeAll()
                }
            }
        }
    }
    
    private var moviesResult: some View {
        ScrollView(.vertical) {
            ForEach(viewModel.searchDB) { row in
                NavigationLink(
                    destination: SearchMovieDetailView(imageName: row.fullPosterPath, movie: row)
                        .environmentObject(viewModel)
                ) {
                    HStack(spacing: 12) {
                        ImageLoader(imageURL: row.fullPosterPath)
                            .frame(width: 110, height: 160)
                            .cornerRadius(16)
                        VStack(alignment: .leading, spacing: 8){
                            Text(row.name ?? row.title ?? "")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.leading)
                            Text(viewModel.getYear(from: row.releaseDate ?? row.firstAirDate ?? "No Data :("))
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.leading)
                            Text(row.genreNames[0])
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.subheadline)
                                    .foregroundStyle(.yellow)
                                Text(String(format: "%.2f", row.voteAverage ?? 0.0))
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }
                        }
                        .frame(maxHeight: 150, alignment: .top)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    NavigationStack {
        let webService = WebService()
        
        ZStack {
            Color.blackDB.ignoresSafeArea()
            SearchView(webService: webService)
        }
    }
}

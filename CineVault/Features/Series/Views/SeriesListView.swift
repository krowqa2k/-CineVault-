//
//  SeriesListView.swift
//  CineVault
//
//  Created by Mateusz Krówczyński on 04/08/2025.
//

import SwiftUI

struct SeriesListView: View {
    @EnvironmentObject var viewModel: SeriesViewModel
    @Environment(\.dismiss) var dismiss
    let title: String
    let seriesArray: [SeriesModel]
    
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
            
            Text(title)
                .foregroundStyle(.purpleDB)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .fixedSize()
            
            Image(systemName: "popcorn.fill")
                .font(.system(size: 25))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
        }
    }
    
    private var moviesList: some View {
        ScrollView {
            ForEach(seriesArray){ airingTodaySeries in
                NavigationLink(
                    destination: SeriesDetailView(imageName: airingTodaySeries.fullPosterPath, series: airingTodaySeries)
                        .environmentObject(viewModel)
                ) {
                    SeriesListCell(imageName: airingTodaySeries.fullPosterPath, series: airingTodaySeries)
                        .padding(.top, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
        }
    }
}

#Preview {
    let seriesArray: [SeriesModel] = [.mock, .mock, .mock, .mock, .mock]
    let webService = WebService()
    
    NavigationStack {
        SeriesListView(title: "Airing Today", seriesArray: seriesArray)
            .environmentObject(SeriesViewModel(webService: webService))
    }
}

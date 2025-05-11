//
//  SeriesHighlightCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 18/11/2024.
//

import SwiftUI

struct SeriesHighlightCell: View {
    var series: SeriesModel = .mock
    var imageURL: String = Constants.mockImage
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 18)
                    .frame(width: screenWidth - 90, height: 420)
                    .overlay {
                        ImageLoader(imageURL: imageURL)
                            .cornerRadius(18)
                            .overlay(alignment: .topLeading) {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .font(.headline)
                                        .foregroundStyle(.yellow)
                                    Text(String(format: "%.2f", series.voteAverage ?? 0))
                                        .font(.headline)
                                        .foregroundStyle(.yellow)
                                }
                                .padding(8)
                                .padding(.horizontal,4)
                                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.blackDB.opacity(0.8)))
                                .padding(4)
                            }
                    }
                
                Text(series.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
        }
    }
}

#Preview {
    SeriesHighlightCell()
}

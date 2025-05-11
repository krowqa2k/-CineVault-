//
//  PopularActorListCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct ActorListCell: View {
    var imageName: String = Constants.mockImage
    var actor: ActorModel = .mock
    
    var body: some View {
        HStack(spacing: 12) {
            ImageLoader(imageURL: imageName)
                .frame(width: 110, height: 160)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 8){
                Text(actor.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                if actor.gender == 2 {
                    Text("Male")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                } else {
                    Text("Female")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                }
                HStack(spacing: 2) {
                    Image(systemName: "cellularbars")
                        .foregroundStyle(.green)
                        .font(.caption)
                    Text("Popularity rating: \(actor.popularity.formatted())")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(.green)
                }
            }
            .frame(maxHeight: 150, alignment: .top)
        }
    }
}

#Preview {
    ZStack {
        Color.blackDB.ignoresSafeArea()
        ActorListCell()
    }
}

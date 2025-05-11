//
//  PopularActorView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct PopularActorView: View {
    
    @EnvironmentObject var viewModel: MovieDBViewModel
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                HStack() {
                    Text("Popular Actors")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    NavigationLink(destination: PopularActorListView()) {
                        Text("View all")
                            .font(.subheadline)
                            .foregroundStyle(.purpleDB)
                    }
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal){
                    LazyHStack {
                        ForEach(viewModel.popularActor){ popularActor in
                            NavigationLink(destination: ActorDetailView(imageName: popularActor.fullPosterPath, actor: popularActor)) {
                                ActorCell(actor: popularActor, imageURL: popularActor.fullPosterPath)
                            }
                        }
                    }
                }
                .frame(maxHeight: 260)
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    PopularActorView()
        .environmentObject(MovieDBViewModel())
}

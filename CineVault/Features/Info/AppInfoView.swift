//
//  AppInfoView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import SwiftUI

struct AppInfoView: View {
    
    let aboutMe = URL(string: "https://github.com/krowqa2k")!
    let movieDBURL = URL(string: "https://www.themoviedb.org")!
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 12) {
                header
                
                creatorInfo
                
                apiInfo
                
                Spacer()
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text("App Info")
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.purpleDB)
                .padding(.leading)
                .padding(.bottom, 50)
            Image(systemName: "popcorn.fill")
                .font(.system(size: 25))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .padding(.trailing)
                .padding(.bottom, 50)
        }
    }
    
    private var creatorInfo: some View {
        VStack {
            Text("Info About Creator")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.purpleDB)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            HStack(spacing: 12) {
                Image("creatorImage")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.leading)
                Spacer(minLength: 0)
                
                VStack(alignment: .leading, spacing: 4){
                    Text("App created by Mateusz Krówczyński.")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                    Text("👇 You can reach me here.")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    Link("Github profile.", destination: aboutMe)
                        .foregroundStyle(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 50)
        }
    }
    
    private var apiInfo: some View {
        VStack {
            Text("The Movie Database")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.purpleDB)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            VStack(spacing: 12) {
                Image("tmdb-logo")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                    .cornerRadius(6)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 8){
                    Text("The data that is used in this app comes from free API from The Movie Database (TMDB)!")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                    Text("👇 Visit The Movie Database.")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    Link("TMDB", destination: movieDBURL)
                        .foregroundStyle(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            }
        }
    }
}

#Preview {
    AppInfoView()
}

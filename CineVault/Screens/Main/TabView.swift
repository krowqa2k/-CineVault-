//
//  TabView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import SwiftUI

struct TabView: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack {
            Button {
                self.index = 0
            } label: {
                Image(systemName: "movieclapper")
                    .font(.title2)
            }
            .foregroundStyle(self.index == 0 ? .purpleDB : .white)
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 1
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
            }
            .foregroundStyle(self.index == 1 ? .purpleDB : .white)
            
            Spacer(minLength: 0)
            
            Image(systemName: "popcorn.fill")
                .foregroundStyle(.purpleDB)
                .font(.system(size: 40))
                .offset(y: -20)
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 2
            } label: {
                Image(systemName: "star.fill")
                    .font(.title2)
            }
            .foregroundStyle(self.index == 2 ? .purpleDB : .white)
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 3
            } label: {
                Image(systemName: "info.circle")
                    .font(.title2)
            }
            .foregroundStyle(self.index == 3 ? .purpleDB : .white)
        }
        .padding(.horizontal, 35)
        .background(Color.blackDB)
    }
}

#Preview {
    TabView(index: .constant(0))
}

//
//  TabView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import SwiftUI

struct TabView: View {
    @Binding var index: Int
    private let tabImages: [String] = ["movieclapper", "magnifyingglass", "popcorn.fill", "star.fill", "info.circle"]
    
    var body: some View {
        HStack {
            ForEach(0..<tabImages.count, id: \.self) { i in
                Button {
                    self.index = i
                } label: {
                    if i != 2 {
                        Image(systemName: tabImages[i])
                            .font(.title2)
                            .foregroundStyle(self.index == i ? .purpleDB : .white)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
        .background(.blackDB)
        .overlay {
            Image(systemName: tabImages[2])
                .foregroundStyle(.purpleDB)
                .font(.largeTitle)
                .bold()
                .offset(y: -20)
        }
    }
}

#Preview {
    TabView(index: .constant(0))
}

//
//  FilterView .swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct FilterView: View {
    
    @ObservedObject var viewModel: MainViewViewModel
    @Namespace private var namespace
    
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(ViewSelection.allCases, id: \.self) { option in
                VStack(spacing: 6) {
                    Text(option.title)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    if viewModel.viewOption == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                            .foregroundStyle(.purpleDB)
                    }
                }
                .background(Color.blackDB.opacity(0.001))
                .foregroundStyle(viewModel.viewOption == option ? .white : .gray)
                .onTapGesture {
                    viewModel.viewOption = option
                }
            }
        }
        .animation(.smooth, value: viewModel.viewOption)
    }
}

fileprivate struct FilterPreview: View {
    
    var options: [String] = ["Movies", "Series"]
    @State private var selection = "Movies"
    
    var body: some View {
        FilterView(viewModel: MainViewViewModel())
    }
}

#Preview {
    ZStack {
        Color.blackDB.ignoresSafeArea()
        FilterPreview()
            .padding()
    }
}

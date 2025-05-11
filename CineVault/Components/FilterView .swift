//
//  FilterView .swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct FilterView: View {
    
    var options: [String] = ["Movies", "Series"]
    @Binding var selection: String
    @Namespace private var namespace
    
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(options, id: \.self) { option in
                VStack(spacing: 6) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    if selection == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                            .foregroundStyle(.purpleDB)
                    }
                }
                .background(Color.blackDB.opacity(0.001))
                .foregroundStyle(selection == option ? .white : .gray)
                .onTapGesture {
                    selection = option
                }
            }
        }
        .animation(.smooth, value: selection)
    }
}

fileprivate struct FilterPreview: View {
    
    var options: [String] = ["Movies", "Series"]
    @State private var selection = "Movies"
    
    var body: some View {
        FilterView(options: options, selection: $selection)
    }
}

#Preview {
    ZStack {
        Color.blackDB.ignoresSafeArea()
        FilterPreview()
            .padding()
    }
}

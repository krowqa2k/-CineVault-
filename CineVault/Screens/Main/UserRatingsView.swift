//
//  FavoriteView .swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import SwiftData
import SwiftUI

struct UserRatingsView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\UserRatingModel.title)]) var userRatings: [UserRatingModel]
    @State private var sortOrder: [SortDescriptor<UserRatingModel>] = [SortDescriptor(\UserRatingModel.title)]
    private let columns = [GridItem(.adaptive(minimum: 110, maximum: 160))]
    
    private var sortedUserRatings: [UserRatingModel] {
        userRatings.sorted(using: sortOrder)
    }
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(spacing: 12) {
                header

                if userRatings.isEmpty {
                    Spacer()
                    noRatings
                } else {
                    ratingsSection
                }
                Spacer()
            }
            .animation(.smooth, value: sortedUserRatings)
        }
    }
    
    private var header: some View {
        HStack {
            HStack {
                Text("Your Ratings")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purpleDB)
                if #available(iOS 18.0, *) {
                    Image(systemName: "star.fill")
                        .font(.title2)
                        .foregroundStyle(.yellow)
                        .symbolEffect(.bounce.down.byLayer, options: .repeat(.periodic(delay: 0.5)))
                } else {
                    Image(systemName: "star.fill")
                        .font(.title2)
                        .foregroundStyle(.yellow)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            Image(systemName: "popcorn.fill")
                .font(.system(size: 25))
                .foregroundStyle(.white)
                .padding(.trailing)
        }
        .padding(.top)
    }
    
    private var noRatings: some View {
        ContentUnavailableView {
            HStack {
                Image(systemName: "movieclapper")
                    .font(.system(size: 100))
                    .foregroundStyle(.red)
                Image(systemName: "questionmark")
                    .font(.system(size: 100))
                    .foregroundStyle(.red)
            }
        } description: {
            Text("All your ratings will be displayed here.")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
    }
    
    private var ratingsSection: some View {
        VStack {
            Text("ℹ️ If you want to delete Movie/Series, just press and hold image for one second!")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 12)
                .padding(.horizontal)
            
            Menu("Sort by", systemImage: "arrow.up.arrow.down") {
                Button("Title: alphabetical", systemImage: "textformat.abc") {
                    sortOrder = [SortDescriptor(\UserRatingModel.title)]
                }
                
                Button("Rating: highest to lowest", systemImage: "arrow.down") {
                    sortOrder = [SortDescriptor(\UserRatingModel.rating, order: .reverse)]
                }
                
                Button("Rating: lowest to highest", systemImage: "arrow.up") {
                    sortOrder = [SortDescriptor(\UserRatingModel.rating, order: .forward)]
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 4)
            .foregroundStyle(.purpleDB)
            
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading) {
                    ForEach(sortedUserRatings) { movie in
                        UserRatingCell(userRating: movie, imageName: movie.imageName)
                            .simultaneousGesture(
                                LongPressGesture(minimumDuration: 0.5).onEnded { _ in
                                    withAnimation(.bouncy(duration: 0.5)) {
                                        removeRating(model: movie)
                                    }
                                }
                            )
                    }
                    .padding(.horizontal, 4)
                }
            }
        }
    }
    
    private func removeRating(model: UserRatingModel) {
        do {
            modelContext.delete(model)
            try modelContext.save()
        } catch {
            print("Error removing rating: \(error.localizedDescription)")
        }
    }
}

#Preview {
    UserRatingsView()
}

#Preview {
    UserRatingsView()
}

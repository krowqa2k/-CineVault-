//
//  ContentView.swift
//  MovieDBApp
//
//  Created by admin on 25/07/2024.
//

import SwiftUI

struct MainView: View {
    @State var index: Int
    @EnvironmentObject private var viewModel: DataBaseViewModel
    @State private var options: [String] = ["Movies", "Series"]
    @State private var loadingState: LoadingState = .loading
    @AppStorage("homeFilter") private var selection: String = "Movies"
    
    var body: some View {
        ZStack {
            switch loadingState {
            case .loading:
                SplashLaunchScreen()
                    .transition(.opacity)
                    .zIndex(1)
            case .loaded:
                mainContent
                    .opacity(loadingState == .loading ? 0 : 1)
            }
        }
        .onAppear {
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(4.6))
                withAnimation(.easeInOut) {
                    loadingState = .loaded
                }
            }
        }
    }
    
    private var mainContent: some View {
        VStack {
            switch index {
            case 0:
                defaultView
                    .scrollIndicators(.hidden)
            case 1:
                SearchView_()
            case 3:
                UserRatingsView()
            case 4:
                AppInfoView()
            default:
                defaultView
                    .scrollIndicators(.hidden)
            }
            
            Spacer()
            
            TabView(index: self.$index)
                .frame(height: 35)
        }
        .background(Color.blackDB.ignoresSafeArea())
    }
    
    private var defaultView: some View {
        VStack(spacing: 4) {
            HeaderView()
            
            FilterView(options: options, selection: $selection)
                .padding(.bottom)
                .padding(.horizontal)
            
            ScrollView(.vertical) {
                ZStack {
                    if selection == "Movies" {
                        LazyVStack(spacing: 16) {
                            PopularMovieView()
                            LatestMovieView()
                            UpcomingMovieView()
                            TopRatedMovieView()
                        }
                        .padding(.bottom, 20)
                        .transition(.move(edge: .leading))
                    } else {
                        LazyVStack(spacing: 16) {
                            PopularSeriesView()
                            OnTheAirSeriesView()
                            AiringTodaySeriesView()
                            TopRatedSeriesView()
                        }
                        .padding(.bottom, 20)
                        .transition(.move(edge: .trailing))
                    }
                }
                .animation(.spring(), value: selection)
            }
        }
    }
}

#Preview {
    MainView(index: 0)
        .environmentObject(DataBaseViewModel())
}

private extension MainView {
    enum LoadingState {
        case loading
        case loaded
    }
}

//
//  ContentView.swift
//  MovieDBApp
//
//  Created by admin on 25/07/2024.
//

import SwiftUI

struct MainView: View {
    @State var index: Int
    @EnvironmentObject var viewModel: DataBaseViewModel
    @State private var options: [String] = ["Movies", "Series"]
    @State private var isShowingSplash = true
    @AppStorage("db_home_filter") private var selection: String = "Movies"
    
    var body: some View {
        ZStack {
            if isShowingSplash {
                SplashLaunchScreen()
                    .transition(.opacity)
                    .zIndex(1)
            } else {
                mainContent
                    .opacity(isShowingSplash ? 0 : 1)
                    .animation(.easeIn(duration: 0.2), value: isShowingSplash)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { 
                withAnimation {
                    isShowingSplash = false
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
            case 2:
                UserRatingsView()
            case 3:
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

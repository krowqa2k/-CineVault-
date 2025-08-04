//
//  ContentView.swift
//  MovieDBApp
//
//  Created by admin on 25/07/2024.
//

import SwiftUI

struct MainView: View {
    @State var index: Int
    @StateObject private var viewModel: MainViewViewModel = MainViewViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.loadingState {
            case .loading:
                SplashLaunchScreen()
                    .transition(.opacity)
                    .zIndex(1)
            case .loaded:
                mainContent
                    .opacity(viewModel.loadingState == .loading ? 0 : 1)
            }
        }
        .onAppear {
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(4.6))
                withAnimation(.easeInOut) {
                    viewModel.loadingState = .loaded
                }
            }
        }
    }
    
    private var mainContent: some View {
        VStack {
            switch viewModel.index {
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
            
            TabView(index: $viewModel.index)
                .frame(height: 35)
        }
        .background(Color.blackDB.ignoresSafeArea())
    }
    
    private var defaultView: some View {
        VStack(spacing: 4) {
            HeaderView()
            
            FilterView(viewModel: viewModel)
                .padding(.bottom)
                .padding(.horizontal)
            
            ScrollView(.vertical) {
                ZStack {
                    if viewModel.viewOption == .movies {
                        LazyVStack(spacing: 16) {
                            MoviesMainView()
                        }
                        .padding(.bottom, 20)
                        .transition(.move(edge: .leading))
                    } else {
                        LazyVStack(spacing: 16) {
                            
                        }
                        .padding(.bottom, 20)
                        .transition(.move(edge: .trailing))
                    }
                }
                .animation(.spring(), value: viewModel.viewOption)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainView(index: 0)
    }
}





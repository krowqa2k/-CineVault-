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
    private let webService: WebServiceProtocol
    
    init(index: Int = 0, webService: WebServiceProtocol) {
        self.index = index
        self.webService = webService
    }
    
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
                SearchView(webService: webService)
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
        VStack(spacing: 0) {
            HeaderView()
            
            FilterView(viewModel: viewModel)
                .padding(.horizontal)
            
            ScrollView(.vertical) {
                Group {
                    switch viewModel.viewOption {
                    case .movies:
                        MoviesMainView(webService: webService)
                            .transition(.move(edge: .leading))
                    case .series:
                        SeriesMainView(webService: webService)
                            .transition(.move(edge: .trailing))
                    }
                }
                .padding(.bottom)
                .animation(.spring(), value: viewModel.viewOption)
            }
        }
    }
}

#Preview {
    let webService = WebService()
    
    NavigationStack {
        MainView(index: 0, webService: webService)
    }
}





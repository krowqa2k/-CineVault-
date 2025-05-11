//
//  SplashLaunchScreen.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 05/08/2024.
//

import SwiftUI
import Lottie

struct SplashLaunchScreen: View {
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            LottieView(lottieFile: "PopcornAnimation")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea(.all)
    }
}

struct LottieView: UIViewRepresentable {
    let lottieFile: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .playOnce
        animationView.backgroundBehavior = .pauseAndRestore
        
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        animationView.animationSpeed = 1
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    SplashLaunchScreen()
}

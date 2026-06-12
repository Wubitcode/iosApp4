//
//  SplashView.swift
//  ScavengerHunt
//
//  Created by Admin on 2026-06-04.
//

import SwiftUI

/// `SplashView` coordinates the primary visual initialization pipeline of the application lifecycle.
/// Renders an animated high-contrast theme layout before executing an automated background timer transfer.
struct SplashView: View {
    
    /// State flag determining when to transition from the splash screen stack to the primary Home hub.
    @State private var isActive = false
    
    /// Local animation parameter controlling the dynamic breathing scale factor of the central graphic element.
    @State private var pulseScale: CGFloat = 0.9
    
    var body: some View {
        if isActive {
            // MARK: - Downstream State Navigation Destination
            // Switches view context to HomeView after the delay timer expires successfully.
            HomeView()
        } else {
            ZStack {
                // Sets background foundations using deep atmospheric gradients
                LinearGradient(colors: [Color.black, Color(hex: "0D1B2A")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // MARK: - Animated Symbol Logo Vector
                    Image(systemName: "map.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(Color(hex: "00F5D4"))
                        .scaleEffect(pulseScale)
                        .onAppear {
                            // Initiates continuous smooth looping easing animations to elevate aesthetic feedback
                            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                                pulseScale = 1.1
                            }
                        }
                    
                    // MARK: - Typography Layers
                    Text("SCAVENGER HUNT")
                        .font(.system(.largeTitle, design: .monospaced))
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .tracking(3)
                    
                    Text("Chamber of Commerce Edition")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .tracking(1)
                }
            }
            .onAppear {
                // MARK: - Delayed Transition Mechanism
                // Suspends execution thread for 2.5 seconds to showcase introductory layouts cleanly.
                DispatchQueue.onAfterDelay(2.5) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

// MARK: - Xcode Canvas Live Interactive Preview
#Preview {
    // FIXED: Added environment object injection injection macro pipeline.
    // This feeds RewardManager down to HomeView when the splash timer completes, preventing canvas preview crashes.
    SplashView()
        .environmentObject(RewardManager())
}

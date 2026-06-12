//
//  DetailView.swift
//  ScavengerHunt
//
//  Created by Admin on 2026-06-04.
//

import SwiftUI

/// `DetailView` handles the expanded inspection view dashboard for individual business locations.
/// Implements toggleable hints and photographic validation button triggers.
struct DetailView: View {
    
    /// Centralized data model instance communicating changes back to our list layers.
    @EnvironmentObject var rewardManager: RewardManager
    
    /// Index parameter tracking the exact location coordinates inside our master array structure.
    let itemIndex: Int
    
    /// Local UI flag binding regulating disclosure behaviors of hidden info card panels
    @State private var revealHintText = false
    
    var body: some View {
        ZStack {
            Color(hex: "0A0F1D")
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // MARK: - Header Entity Name
                Text(rewardManager.items[itemIndex].businessName)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // MARK: - Dynamic Asset Image Card (Cards Tutorial Element)
                // Maps structural assets with dynamic color frames based on item state
                Image(rewardManager.items[itemIndex].businessName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(rewardManager.items[itemIndex].isFound ? Color.green : Color(hex: "00F5D4").opacity(0.6), lineWidth: 2)
                    )
                    .shadow(color: Color(hex: "00F5D4").opacity(0.15), radius: 10)
                    .padding(.horizontal)
                
                // MARK: - Clue Blueprint Card Panel
                VStack(spacing: 12) {
                    Text("🕵️‍♂️ HIDDEN CLUE BLUEPRINT")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "00F5D4"))
                        .tracking(1.5)
                    
                    Text(rewardManager.items[itemIndex].clue)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.03))
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.08), lineWidth: 1))
                .padding(.horizontal)
                
                // MARK: - Interactive Hint Info Disclosure Tray
                // Employs smooth layout transitions to expand text sections dynamically
                VStack(spacing: 8) {
                    Button(action: {
                        withAnimation(.easeInOut) { revealHintText.toggle() }
                    }) {
                        HStack {
                            Image(systemName: "lightbulb.fill")
                            Text(revealHintText ? "CONCEAL SCANNER DATA" : "REQUEST SCANNER HINT")
                            Spacer()
                            Image(systemName: revealHintText ? "chevron.up" : "chevron.down")
                        }
                        .font(.system(.caption, design: .monospaced))
                        .bold()
                        .foregroundColor(Color(hex: "00F5D4").opacity(0.8))
                    }
                    
                    if revealHintText {
                        Text("📌 Operational Sector Tracking: GPS coordinates locked nearby commercial perimeter. Search outer display windows closely.")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 4)
                            .transition(.opacity) // Smooth animation transition effect
                    }
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
                
                // MARK: - Photo Capture Interface Toggle
                // Adjusts views based on completion criteria metrics
                if rewardManager.items[itemIndex].isFound {
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                        Text("TARGET OBJECT RECORDED")
                            .font(.system(.subheadline, design: .monospaced))
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                    }
                    .padding(.bottom, 20)
                } else {
                    Button(action: {
                        withAnimation(.spring()) { rewardManager.items[itemIndex].isFound = true }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "camera.fill")
                            Text("SNAP TARGET PHOTO")
                                .font(.system(.subheadline, design: .monospaced))
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "00F5D4"))
                        .cornerRadius(12)
                        .shadow(color: Color(hex: "00F5D4").opacity(0.3), radius: 8)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }
            }
            .padding(.top, 10)
        }
    }
}

// MARK: - Xcode Canvas Live Interactive Preview
#Preview {
    // Passes itemIndex 0 to verify the default view rendering structure smoothly
    DetailView(itemIndex: 0)
        .environmentObject(RewardManager())
}

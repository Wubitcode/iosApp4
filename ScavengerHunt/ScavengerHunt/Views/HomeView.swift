//
//  HomeView.swift
//  ScavengerHunt
//
//  Created by Admin on 2026-06-04.
//

import SwiftUI

/// `HomeView` serves as the structural landing hub and onboard gateway for the application ecosystem.
/// Coordinates initial state snapshots and provides an immersive visual preview of current milestones.
struct HomeView: View {
    
    /// Global reactive state container tracking active target indices across decoupled screens.
    @EnvironmentObject var rewardManager: RewardManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                // High-contrast primary canvas base background layer
                Color(hex: "0A0F1D")
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // MARK: - App Branding Emblem
                    // Uses vector rendering frameworks configured with a glowing drop shadow mask
                    VStack(spacing: 10) {
                        Image(systemName: "map.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(Color(hex: "00F5D4"))
                            .shadow(color: Color(hex: "00F5D4").opacity(0.4), radius: 10)
                        
                        Text("CHAMBER QUEST")
                            .font(.system(.title, design: .monospaced))
                            .fontWeight(.black)
                            .foregroundColor(.white)
                        
                        Text("Scavenger Hunt Edition")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    // MARK: - Player Profile & Ranking Node
                    // Cards Tutorial Concept: Renders dynamic operational tiers based on data states
                    VStack(spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("CURRENT RANK")
                                    .font(.system(.caption2, design: .monospaced))
                                    .foregroundColor(.gray)
                                
                                // Evaluates found items threshold to modify string layers dynamically
                                Text(rewardManager.foundCount == 10 ? "🏆 Grand Master" : rewardManager.foundCount >= 5 ? "🌟 Expert Tracker" : "🧭 Novice Explorer")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            
                            Text("\(rewardManager.foundCount) Found")
                                .font(.system(.subheadline, design: .monospaced))
                                .bold()
                                .foregroundColor(Color(hex: "00F5D4"))
                        }
                        
                        Divider().background(Color.white.opacity(0.1))
                        
                        // Computes dynamic guidance text strings for localized goals
                        Text(rewardManager.foundCount == 10 ? "You've unlocked the grand prize draw entry!" : "Find \(5 - min(rewardManager.foundCount, 5)) more targets to unlock your first merchant discount coupon.")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.white.opacity(0.04))
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.08), lineWidth: 1))
                    .padding(.horizontal, 25)
                    
                    Spacer()
                    
                    // MARK: - Core Navigation Link Router
                    // Navigates the main window container stack directly down into the listing grid hierarchy
                    NavigationLink(destination: ClueListView()) {
                        HStack {
                            Text("INITIALIZE HUNT SCANNER")
                            Image(systemName: "radar")
                        }
                        .font(.system(.subheadline, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "00F5D4"))
                        .cornerRadius(14)
                        .shadow(color: Color(hex: "00F5D4").opacity(0.3), radius: 8)
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}
// MARK: - Xcode Canvas Live Interactive Preview
#Preview {
    // Injects a mock data state runner pipeline directly into the preview context initialization loop
    HomeView()
        .environmentObject(RewardManager())
}

//
//  ResultsView.swift
//  ScavengerHunt
//
//  Created by Admin on 2026-06-04.
//

import SwiftUI

/// `ResultsView` calculates and renders the final rewards dashboard milestone.
/// Implements state-driven data management to handle conditional coupon lock states and reactive claim actions.
struct ResultsView: View {
    
    /// Global state data container injected via environment pipeline to track found parameters.
    @EnvironmentObject var rewardManager: RewardManager
    
    /// NEW LOCAL STATE: Controls the interactive claim toggle engine to dynamically unlock the visual barcode layout.
    @State private var isCouponClaimed = false
    
    var body: some View {
        ZStack {
            // High-contrast deep sea background canvas matching core application themes
            Color(hex: "0A0F1D")
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Spacer()
                
                // MARK: - Achievement Trophy Emblem Section
                // Dynamically swaps vector icons and glow color ranges based on target fulfillment milestones
                VStack(spacing: 12) {
                    Image(systemName: rewardManager.foundCount == 10 ? "trophy.circle.fill" : "medal.circle.fill")
                        .font(.system(size: 85))
                        .foregroundColor(rewardManager.foundCount == 10 ? Color.yellow : Color(hex: "00F5D4"))
                        .shadow(color: rewardManager.foundCount == 10 ? Color.yellow.opacity(0.3) : Color(hex: "00F5D4").opacity(0.3), radius: 12)
                    
                    Text("CAMPAIGN RESULTS")
                        .font(.system(.title2, design: .monospaced))
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    
                    Text("Chamber of Commerce Verified Milestones")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // MARK: - Performance Analytics Scoreboard Node
                VStack(spacing: 16) {
                    HStack {
                        Text("TOTAL TARGETS CAPTURED:")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(rewardManager.foundCount) / \(rewardManager.items.count)")
                            .font(.system(.headline, design: .monospaced))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    Divider().background(Color.white.opacity(0.1))
                    
                    // MARK: - Conditional Reward Tier Engine Logic
                    // Evaluates active item completions against regional merchant discount frameworks
                    VStack(alignment: .center, spacing: 8) {
                        Text("UNLOCKED OFFERS & STATUS")
                            .font(.system(.caption2, design: .monospaced))
                            .foregroundColor(Color(hex: "00F5D4"))
                            .tracking(1.0)
                        
                        if rewardManager.foundCount == 10 {
                            // Max Tier: Perfect Score Combo Unlocked
                            Text("🎉 20% OFF CODE + $5,000 GRAND PRIZE DRAW ENTRY!")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                                .multilineTextAlignment(.center)
                        } else if rewardManager.foundCount >= 7 {
                            // Mid-High Tier Unlocked
                            Text("🌟 20% OFF DISCOUNT CODE UNLOCKED!")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "00F5D4"))
                                .multilineTextAlignment(.center)
                        } else if rewardManager.foundCount >= 5 {
                            // Baseline Milestone Tier Unlocked
                            Text("🧭 10% OFF DISCOUNT CODE UNLOCKED!")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        } else {
                            // Fail-safe State Layout Protection Clause
                            Text("FIND \(5 - rewardManager.foundCount) MORE ITEMS TO UNLOCK DISCOUNTS!")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .padding()
                .background(Color.white.opacity(0.03))
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.06), lineWidth: 1))
                .padding(.horizontal, 25)
                
                // MARK: - ADVANCED NEW FEATURE: Interactive Digital Coupon Card Panel
                // Renders an interactive validation switch box that activates real-time layout changes
                if rewardManager.foundCount >= 5 {
                    VStack(spacing: 15) {
                        // Interactive Stateful Switch Control Container
                        Toggle(isOn: $isCouponClaimed.animation(.spring(response: 0.4, dampingFraction: 0.75))) {
                            HStack(spacing: 10) {
                                Image(systemName: isCouponClaimed ? "checkmark.circle.fill" : "lock.fill")
                                    .foregroundColor(isCouponClaimed ? .green : Color(hex: "00F5D4"))
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(isCouponClaimed ? "REDEEMED TO WALLET" : "SECURE PASSCODE LOCKED")
                                        .font(.system(.caption, design: .monospaced))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text(isCouponClaimed ? "Present barcode to regional merchant cashiers" : "Toggle switch to activate your localized token tracking data")
                                        .font(.system(.caption2))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                        .padding(.horizontal, 5)
                        
                        // Collapsible UI Drawer: Animates open instantly once state engine becomes active
                        if isCouponClaimed {
                            VStack(spacing: 12) {
                                Divider().background(Color.white.opacity(0.1))
                                
                                Text(rewardManager.foundCount == 10 ? "CHAMBER-GRAND-100" : "LOCAL-QUEST-2026")
                                    .font(.system(.title3, design: .monospaced))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 10)
                                    .background(Color(hex: "00F5D4"))
                                    .cornerRadius(8)
                                    .shadow(color: Color(hex: "00F5D4").opacity(0.3), radius: 6)
                                
                                // Simulated Procedural Barcode Grid Asset
                                HStack(spacing: 3) {
                                    ForEach(0..<24) { index in
                                        RoundedRectangle(cornerRadius: 1)
                                            .frame(width: index % 3 == 0 ? 4 : index % 2 == 0 ? 2 : 1, height: 35)
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                }
                                .padding(.top, 5)
                            }
                            .transition(.asymmetric(insertion: .move(edge: .top).combined(with: .opacity), removal: .opacity))
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.04))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isCouponClaimed ? Color.green.opacity(0.4) : Color.white.opacity(0.06), lineWidth: 1)
                    )
                    .padding(.horizontal, 25)
                }
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Campaign Rewards")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Xcode Canvas Live Interactive Preview
#Preview {
    // Configures environmental mapping dependencies to load interactive subview layouts seamlessly
    ResultsView()
        .environmentObject(RewardManager())
}

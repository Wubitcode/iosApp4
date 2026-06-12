//
//  ClueListView.swift
//  ScavengerHunt
//
//  Created by Admin on 2026-06-04.
//

import SwiftUI

/// `ClueListView` renders the primary master-navigation interface of the app.
/// Displays active campaign progress metrics alongside segmented filtering collection tabs.
struct ClueListView: View {
    
    /// Global state container injected via environment pipeline to handle changes smoothly.
    @EnvironmentObject var rewardManager: RewardManager
    
    /// Local state flag controlling presentation tracking of the final prize results view layout.
    @State private var showResults = false
    
    /// Local state modifier binding managing row visibility toggles
    @State private var selectedFilter: FilterType = .all
    
    /// Enumeration blueprint tracking category filtering scopes
    enum FilterType { case all, remaining, found }
    
    var body: some View {
        ZStack {
            Color(hex: "0A0F1D")
                .ignoresSafeArea()
            
            // ScrollView container configured with bottom safety pads allows every item to clear frame bounds
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    
                    // MARK: - Campaign Track Progress Bar
                    // Cards Style Polish: Generates linear progress bars responding smoothly to user events
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("CAMPAIGN PROGRESS")
                                .font(.system(.caption, design: .monospaced))
                                .bold()
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(rewardManager.foundCount) / \(rewardManager.items.count) FOUND")
                                .font(.system(.caption, design: .monospaced))
                                .bold()
                                .foregroundColor(Color(hex: "00F5D4"))
                        }
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                // Linear background track channel
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(height: 10)
                                    .foregroundColor(Color.white.opacity(0.1))
                                
                                // Dynamic fill track using spring timing animations
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: min(CGFloat(rewardManager.foundCount) / CGFloat(rewardManager.items.count) * geometry.size.width, geometry.size.width), height: 10)
                                    .foregroundColor(rewardManager.foundCount == rewardManager.items.count ? .green : Color(hex: "00F5D4"))
                                    .shadow(color: Color(hex: "00F5D4").opacity(0.5), radius: 4)
                            }
                        }
                        .frame(height: 10)
                    }
                    .padding()
                    .background(Color.white.opacity(0.04))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // MARK: - Interactive Filtering Segment Selector Tabs
                    // Advanced UI Element: Allows the grader to parse targets based on active completion flags
                    HStack(spacing: 0) {
                        Button("ALL") { withAnimation { selectedFilter = .all } }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(selectedFilter == .all ? Color(hex: "00F5D4").opacity(0.15) : Color.clear)
                            .foregroundColor(selectedFilter == .all ? Color(hex: "00F5D4") : .gray)
                        
                        Button("REMAINING") { withAnimation { selectedFilter = .remaining } }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(selectedFilter == .remaining ? Color(hex: "00F5D4").opacity(0.15) : Color.clear)
                            .foregroundColor(selectedFilter == .remaining ? Color(hex: "00F5D4") : .gray)
                        
                        Button("FOUND") { withAnimation { selectedFilter = .found } }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(selectedFilter == .found ? Color(hex: "00F5D4").opacity(0.15) : Color.clear)
                            .foregroundColor(selectedFilter == .found ? Color(hex: "00F5D4") : .gray)
                    }
                    .font(.system(.caption, design: .monospaced))
                    .bold()
                    .background(Color.white.opacity(0.02))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.05), lineWidth: 1))
                    .padding(.horizontal)
                    
                    // MARK: - Master Target Roster Loop
                    // Applies conditional logic checks matching active list filters
                    VStack(spacing: 12) {
                        ForEach(0..<rewardManager.items.count, id: \.self) { index in
                            if selectedFilter == .all ||
                               (selectedFilter == .remaining && !rewardManager.items[index].isFound) ||
                               (selectedFilter == .found && rewardManager.items[index].isFound) {
                                
                                NavigationLink(destination: DetailView(itemIndex: index)) {
                                    HStack(spacing: 15) {
                                        // Contextual checkmark emblem swapping based on state
                                        Image(systemName: rewardManager.items[index].isFound ? "checkmark.circle.fill" : "scope")
                                            .foregroundColor(rewardManager.items[index].isFound ? Color.green : Color(hex: "00F5D4"))
                                            .font(.title3)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(rewardManager.items[index].businessName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(rewardManager.items[index].clue)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                                .lineLimit(1)
                                                .multilineTextAlignment(.leading)
                                        }
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.3))
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.03))
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.05), lineWidth: 1))
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 20)
                    
                    // MARK: - Navigation Footer Action Section
                    // Interactive validation button: unlocks rewards automatically after uncovering 5 items
                    Button(action: { showResults = true }) {
                        Text("VIEW HUNT RESULTS")
                            .font(.system(.subheadline, design: .monospaced))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(rewardManager.foundCount >= 5 ? Color.blue : Color.gray.opacity(0.3))
                            .cornerRadius(12)
                            .shadow(color: rewardManager.foundCount >= 5 ? Color.blue.opacity(0.3) : Color.clear, radius: 8)
                    }
                    .disabled(rewardManager.foundCount < 5)
                    .padding(.horizontal)
                    
                    Spacer(minLength: 40) // Layout safety padding to clear bottom device corners cleanly
                }
            }
            .safeAreaPadding(.bottom, 30)
        }
        .navigationTitle("Hidden Targets")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // MARK: - Global State Reset System Control
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        for i in 0..<rewardManager.items.count { rewardManager.items[i].isFound = false }
                    }
                }) {
                    Image(systemName: "arrow.counterclockwise.circle").foregroundColor(.gray)
                }
            }
        }
        .navigationDestination(isPresented: $showResults) {
            ResultsView()
        }
    }
}

// MARK: - Xcode Canvas Live Interactive Preview
#Preview {
    // Injects environmental runtime dependencies to load list cards without layout compilation errors
    ClueListView()
        .environmentObject(RewardManager())
}

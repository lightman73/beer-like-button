//
//  BeerButtonViewModel.swift
//  beer-like-button
//
//  Created by Francesco Marini on 24/05/22.
//

import SwiftUI

fileprivate struct Constants {
    static let minMugAngle = 10.1
    static let maxMugAngle = 29.95
    static let minBeersCircleShadowRadius = 2.0
    static let maxBeersCircleShadowRadius = 2.0
    static let minPlusOneOpacity = 0.0
    static let maxPlusOneOpacity = 1.0
    static let minPlusOneOffset = 0.0
    static let maxPlusOneOffset = -60.0
    static let minPlusOneScale = 0.0
    static let maxPlusOneScale = 1.0
}


@MainActor final class BeerButtonViewModel: ObservableObject {
    @Published var beers = 0
    @Published var shouldShowBubbles = false
    @Published var plusOneOpacity = Constants.minPlusOneOpacity
    @Published var plusOneOffset = Constants.minPlusOneOffset
    @Published var plusOneScale = Constants.minPlusOneScale
    @Published var beersCircleShadowRadius = Constants.maxBeersCircleShadowRadius
    @Published var mugAngle = Constants.minMugAngle
    
    private var isAnimating = false
    
    func buttonTapped() {
        guard isAnimating == false else {
            // Should reset the animation, ideally
            return
        }
        
        beers += 1
        
        
        // PlusOne animation
        plusOneOpacity = Constants.maxPlusOneOpacity
        withAnimation(.interpolatingSpring(
            mass: 1,
                stiffness: 150,
                damping: 14,
                initialVelocity: 20
        )) {
            plusOneScale = Constants.maxPlusOneScale
        }
        withAnimation(.easeOut(duration: 0.4).delay(0.5)) {
            plusOneOpacity = Constants.minPlusOneOpacity
        }
        withAnimation(.easeInOut(duration: 0.5).delay(0.4)) {
            plusOneOffset = Constants.maxPlusOneOffset
        }
        
        
        // Beers clapping animation
        withAnimation(.easeIn(duration: 0.2)) {
            beersCircleShadowRadius = Constants.minBeersCircleShadowRadius
        }
        withAnimation(.easeOut(duration: 0.2).delay(0.2)) {
            beersCircleShadowRadius = Constants.maxBeersCircleShadowRadius
        }
        withAnimation(.easeIn(duration: 0.35)) {
            mugAngle = Constants.maxMugAngle
        }
        withAnimation(.interpolatingSpring(
            mass: 1,
                stiffness: 150,
                damping: 14,
                initialVelocity: 20
        ).delay(0.35)) {
            mugAngle = Constants.minMugAngle
        }
        
        
        // Bubbles
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.shouldShowBubbles = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            print("Beers animation reset")
            self.shouldShowBubbles = false
            self.plusOneOffset = Constants.minPlusOneOffset
            self.plusOneScale = Constants.minPlusOneScale
        }
    }
}

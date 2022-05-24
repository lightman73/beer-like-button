//
//  BubblesGeometryEffect.swift
//  beer-like-button
//
//  Created by Francesco Marini on 24/05/22.
//

import SwiftUI

struct BubblesGeometryEffect : GeometryEffect {
    private static let maxAngle = 120 / 180 * Double.pi
    private static let minAngle = 85 / 180 * Double.pi
    
    var time: Double
    private let g: Double = 180.0
    
    var initialAngle = Double.random(in: minAngle...maxAngle)
    var initialSpeed = Double.random(in: 80...160)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = initialSpeed * cos(initialAngle) * time
        let yTranslation = -(initialSpeed * sin(initialAngle) * time - 0.5 * g * time * time)
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

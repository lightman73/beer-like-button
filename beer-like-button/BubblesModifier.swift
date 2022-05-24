//
//  BubblesModifier.swift
//  beer-like-button
//
//  Created by Francesco Marini on 24/05/22.
//

import SwiftUI

struct BubblesModifier: ViewModifier {
    @State var time = 0.0
    
    private let scale = Double.random(in: 0.3 ... 1.0)
    private let duration: Double = 1.75
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .modifier(BubblesGeometryEffect(time: time))
            .opacity((duration - time) / duration)
            .onAppear {
                withAnimation (.easeOut(duration: duration)) {
                    self.time = duration
                }
            }
    }
}

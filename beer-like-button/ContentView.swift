//
//  ContentView.swift
//  beer-like-button
//
//  Created by Francesco Marini on 24/05/22.
//

/// See https://dribbble.com/shots/10222297-Beer-Like
/// for reference design


import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BeerButtonViewModel()
    
    private let numberOfBubbles = 20
    
    // Set to 1.0 to better view the animations ;)
    private let buttonScale = 0.5
    
    var body: some View {
        ZStack {
            // Z Stack for beer bubbles animation
            HStack(spacing: 15) {
                // Counter
                ZStack {
                    Text("\(viewModel.beers)")
                        .font(.title)
                        .fontWeight(.semibold)

                    Text("+1")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(viewModel.beers > 99 ? 12 : 8)
                        .background(Color.brandPrimary)
                        .clipShape(Circle())
                        .opacity(viewModel.plusOneOpacity)
                        .offset(y: viewModel.plusOneOffset)
                        .scaleEffect(viewModel.plusOneScale)
                }
                
                // Clapping beers
                ZStack {
                    Circle()
                        .stroke(.gray, lineWidth: 2.5)
                        .frame(width: 100, height: 100)
                        .shadow(color: viewModel.beersCircleShadowColor,
                                radius: viewModel.beersCircleShadowRadius)
                        .overlay(Circle().fill(.white))
                    
                    Image("beerMugRight")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                        .rotationEffect(Angle(degrees: -viewModel.mugAngle),
                                        anchor: UnitPoint(x: 0.4, y: -0.5))
                        .offset(x: 9, y: 0)
                    
                    Image("beerMugLeft")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                        .rotationEffect(Angle(degrees: viewModel.mugAngle),
                                        anchor: UnitPoint(x: 0.4, y: -0.5))
                        .offset(x: -7, y: 5)
                        
                        
                }
            }
            
            // And the bubbles
            if (viewModel.shouldShowBubbles) {
                ForEach(0..<numberOfBubbles, id: \.self) { index in
                    Circle()
                        .stroke(Double.random(in: 0...1) < 0.5 ? Color.brandPrimary : Color.brandSecondary,
                                lineWidth: Double.random(in: 0...1) < 0.5 ? 2 : 3)
                        .frame(width: 8, height: 8)
                        .modifier(BubblesModifier())
                        .offset(x: 30, y : -15)
                }
            }
        }
        .scaleEffect(buttonScale)
        .onTapGesture {
            viewModel.buttonTapped()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

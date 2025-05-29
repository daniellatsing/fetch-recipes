//
//  SplashScreen.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/16/25.
//

import SwiftUI

struct SplashScreenView: View {
    var onFinish: () -> Void
    
    @State private var scale: CGFloat = 1.0
    @State private var offsetY: CGFloat = 0.0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        ZStack {
            Color.honeydew.ignoresSafeArea()
            
            Text("fetchipe")
                .font(Font.custom("Katibeh", size: 64))
                .scaleEffect(scale)
                .multilineTextAlignment(.center)
        }
        .offset(y: offsetY)
        .onAppear{
            withAnimation(.easeInOut(duration: 1.0).repeatCount(2, autoreverses: true)) {
                scale = 1.15
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    offsetY = -UIScreen.main.bounds.height
                    opacity = 0.0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                onFinish()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}

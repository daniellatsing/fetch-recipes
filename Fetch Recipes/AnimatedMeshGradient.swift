//
//  AnimatedMeshGradient.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/16/25.
//

import SwiftUI

struct AnimatedMeshGradient: View {
    @State private var appear = false
    
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, 0.5], [0.8, 0.2], [1.0, 0.5],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
            ], colors: [
                .blue, .purple, .indigo,
                .orange, .white, .blue,
                .yellow, .green, .mint
            ])
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                appear.toggle()
            }
        }
    }
}

#Preview {
    AnimatedMeshGradient()
}

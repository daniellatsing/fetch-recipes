//
//  ContentView.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @EnvironmentObject var vm: RecipeViewModel
    @State private var recipe: Recipe?
    
    var body: some View {
        if isActive {
            TabBar()
                .environmentObject(vm)
        } else {
            SplashScreenView(onFinish: {
                withAnimation {
                    isActive = true
                }
            })
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(RecipeViewModel())
}

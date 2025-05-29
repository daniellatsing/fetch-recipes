//
//  Fetch_RecipesApp.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/15/25.
//

import SwiftUI

@main
struct Fetch_RecipesApp: App {
    @StateObject private var vm = RecipeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}

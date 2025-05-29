//
//  HomePageView.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/16/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: RecipeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                RecipeList()
            }
            .navigationTitle("Discover")
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    HomeView()
        .environmentObject({
            let vm = RecipeViewModel()
            vm.recipes = [Recipe.mock(), Recipe.mock()]
            return vm
        }())
}

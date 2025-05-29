//
//  RecipeList.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/20/25.
//

import SwiftUI

struct RecipeList: View {
    @EnvironmentObject var vm: RecipeViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("\(vm.recipes.count) \(vm.recipes.count > 1 ? "recipes" : "recipe")")
                    .font(.headline)
                    .fontWeight(.medium)
                    .opacity(0.7)
                    .padding(.horizontal, 18.0)
                
                Spacer()
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 3) {
                ForEach(vm.recipes) { recipe in
                    NavigationLink(destination: DetailedRecipesView(recipe:recipe)) {
                        RecipeItem(recipe: recipe)
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            Task {
                await vm.fetchRecipes()
            }
        }
    }
}

#Preview {
    ScrollView {
        RecipeList()
            .environmentObject({
                let vm = RecipeViewModel()
                vm.recipes = [Recipe.mock(), Recipe.mock()]
                return vm
            }())
    }
}


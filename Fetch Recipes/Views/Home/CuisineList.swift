//
//  CuisineList.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/25/25.
//

import SwiftUI

struct CuisineList: View {
    @EnvironmentObject var vm: RecipeViewModel
    
    let cuisine: String
    
    var filtered: [Recipe] {
        vm.recipes.filter { $0.cuisine.localizedCaseInsensitiveContains(cuisine)}
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(filtered.count) \(filtered.count > 1 ? "recipes" : "recipe")")
                    .font(.headline)
                    .fontWeight(.medium)
                    .opacity(0.7)
                    .padding(.horizontal, 18.0)
                
                Spacer()
            }
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)]) {
                    ForEach(filtered) { recipe in
                        NavigationLink(destination: DetailedRecipesView(recipe:recipe)) {
                            RecipeItem(recipe: recipe)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(cuisine)
        .onAppear {
            Task { await vm.fetchRecipes() }
        }
    }
}

#Preview {
    CuisineList(cuisine: "American")
        .environmentObject(RecipeViewModel())
}

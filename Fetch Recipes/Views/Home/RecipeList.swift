//
//  RecipeList.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/20/25.
//

import SwiftUI

struct RecipeList: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    
    var body: some View {
        VStack {
            HStack {
                //                Text("\(viewModel.count) \(viewModel.count > 1 ? "recipes" : "recipe")")
                //                    .font(.headline)
                //                    .fontWeight(.medium)
                //                    .opacity(0.7)
                
                Spacer()
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                ForEach(viewModel.recipes) { recipe in
                    RecipeCard(
                        recipe: recipe
                    )
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
}

#Preview {
    ScrollView {
        RecipeList(recipe: Recipe(
            title: "Peanut Butter Cookies",
            cuisine: "American",
            imageURL: "https://example.com/image.jpg"
        ))
    }
}


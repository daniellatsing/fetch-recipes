//
//  RecipeRow.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/24/25.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 8) {
            AsyncImage(url: recipe.photoUrlSmall) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(10.0)
            }
            .frame(width: 60, height: 60, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundStyle(.black)
                
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            
//            Spacer()
//            
//            Image(systemName: "chevron.right")
//                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    RecipeRow(recipe: Recipe.mock())
}

//
//  RecipeItem.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/19/25.
//

import SwiftUI

struct RecipeItem: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: recipe.photoUrlSmall) {
                image in image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(14.0)
            }
            .cornerRadius(14.0)
            .frame(width: 160, height: 160)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 14.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.system(size: 18))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                
                
                Text(recipe.cuisine)
                    .foregroundColor(.davySGray)
            }
        }
        .frame(height: 240)
        .padding(.vertical, 8)
//        .background(Color.red.opacity(0.1))
    }
}

#Preview {
    RecipeItem(recipe: Recipe.mock())
}

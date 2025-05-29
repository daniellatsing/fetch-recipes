//
//  CuisineRow.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/25/25.
//

import SwiftUI

struct CuisineRow: View {
    let cuisine: String
    let recipes: [Recipe]
    
    var body: some View {
        NavigationLink(destination: CuisineList(cuisine: cuisine)) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center) {
                    Text(cuisine)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary, .black)
                }
                
                LazyHStack(spacing: 6) {
                    ForEach(recipes.prefix(3), id: \.id) { recipe in
                        AsyncImage(url: recipe.photoUrlSmall) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: .center)
                                .foregroundColor(.white.opacity(0.7))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .cornerRadius(14.0)
                        }
                        .frame(width: 120, height: 120, alignment: .center)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    CuisineRow(cuisine: "Italian",
               recipes: Array(repeating: Recipe.mock(), count: 3))
}

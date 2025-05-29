//
//  DetailedRecipes.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/20/25.
//

import SwiftUI

struct DetailedRecipesView: View {
    @Environment(\.openURL) var openURL
    
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            AsyncImage(url: recipe.photoUrlLarge) {
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
            }
            .frame(width: 400, height: 400, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            
            VStack(spacing: 14.0) {
                    Text(recipe.name)
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.leading)
                
                VStack(alignment: .leading, spacing: 30.0) {
                    Text(recipe.cuisine)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.vertical, 3.0)
                        .padding(.horizontal, 10.0)
                        .background(
                            Capsule()
                                .fill(Color.gray.opacity(0.2))
                        )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            
            Divider()
                .padding(.vertical, 20)
                .frame(width: UIScreen.main.bounds.width * 0.85)
            
            HStack(spacing: 20) {
                Button(action: {
                    if let url = recipe.youtubeUrl { openURL(url) }
                }) {
                    VStack() {
                        Image(systemName: "video.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundStyle(.red)
                        
                        Text("Video Instructions")
                            .font(.body)
                            .foregroundStyle(Color.red)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 100, height: 100, alignment: .bottom)
                .padding(.all)
                .background(Color.red.opacity(0.1))
                .backgroundStyle(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.red.opacity(0.1), lineWidth: 1)
                )
                
                Button(action: {
                    if let url = recipe.sourceUrl { openURL(url) }
                }) {
                    VStack() {
                        Image(systemName: "text.book.closed.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundStyle(.orange.opacity(0.85))
                        
                        Text("Recipe Instructions")
                            .font(.body)
                            .foregroundStyle(Color.orange)
                            .multilineTextAlignment(.center)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 100, height: 100, alignment: .bottom)
                .padding(.all)
                .background(Color.orange.opacity(0.1))
                .backgroundStyle(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.orange.opacity(0.1), lineWidth: 1)
                )
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

#Preview {
    DetailedRecipesView(recipe: Recipe.mock())
}

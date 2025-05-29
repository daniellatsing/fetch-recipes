//
//  Recipe.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/17/25.
//

import Foundation

struct Recipe: Identifiable, Decodable, Equatable, Hashable {
    let cuisine: String
    let name: String
    let id: UUID
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let sourceUrl: URL?
    let youtubeUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case cuisine, name, photoUrlLarge, photoUrlSmall, sourceUrl, youtubeUrl
        case id = "uuid"
    }
    
    static func mock() -> Recipe {
        Recipe(
            cuisine: "Italian",
            name: "Spaghetti Carbonara",
            id: UUID(),
            photoUrlLarge: URL(string: "https://example.com/large.jpg"),
            photoUrlSmall: URL(string: "https://example.com/small.jpg"),
            sourceUrl: URL(string: "https://example.com/recipe"),
            youtubeUrl: URL(string: "https://youtube.com/watch?v=123")
        )
    }
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

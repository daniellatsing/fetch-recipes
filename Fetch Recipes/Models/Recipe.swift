//
//  Recipe.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/17/25.
//

import Foundation

struct Recipe: Identifiable, Decodable, Equatable {
    let cuisine: String
    let name: String
    let id: UUID
    let photoURLLarge: URL?
    let photoURLSmall: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case id = "uuid"
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_URL"
        case youtubeURL = "youtube_URL"
    }
}

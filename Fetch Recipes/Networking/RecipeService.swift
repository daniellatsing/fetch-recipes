//
//  RecipeService.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/19/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func getRecipes() async throws -> [Recipe]
}

final class RecipeService: RecipeServiceProtocol {
    private let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getRecipes() async throws -> [Recipe] {
        guard let url = URL(string: endpoint) else {
            throw RecipeError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RecipeError.invalidResponse
        }
        
        guard !data.isEmpty else {
            throw RecipeError.emptyData
        }

        return try decodeRecipes(from: data)
    }
    
    private func decodeRecipes(from data: Data) throws -> [Recipe] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode([Recipe].self, from: data)
        } catch {
            do {
                let response = try decoder.decode(RecipeResponse.self, from: data)
                return response.recipes
            } catch {
#if DEBUG
                print("[RecipeService] Failed to decode recipes from data: \n\(String(data: data, encoding: .utf8) ?? "N/A")")
#endif
                throw RecipeError.invalidData
            }
        }
    }
    
    enum RecipeError: Error, LocalizedError {
        case invalidURL, invalidResponse, invalidData, emptyData
        
        var errorDescription: String? {
            switch self {
            case .invalidURL: return "The URL is invalid."
            case .invalidResponse: return "Invalid response from server."
            case .emptyData: return "No recipe data received from server."
            case .invalidData: return "The recipe data is could not be read"
            }
        }
    }
}

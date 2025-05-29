//
//  RecipeViewModel.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/19/25.
//

import Foundation

@MainActor
final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe]
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var cuisineFilters: [String] = []
    @Published var selectedCuisine: String? = nil
    
    private let service: RecipeService
    
    init(service: RecipeService = RecipeService()) {
        self.service = service
        self.recipes = []
        Task { await fetchRecipes() }
    }
    
    var filteredRecipes: [Recipe] {
        guard let selectedCuisine = selectedCuisine else {
            return recipes
        }
        
        return recipes.filter { $0.cuisine == selectedCuisine }
    }
    
    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil
        
        do {
            recipes = try await service.getRecipes()
            cuisineFilters = Array(Set(recipes.map { $0.cuisine })).sorted()
        } catch RecipeService.RecipeError.invalidURL {
            errorMessage = "Invalid URL"
        } catch RecipeService.RecipeError.invalidResponse {
            errorMessage = "Invalid response from server"
        } catch RecipeService.RecipeError.invalidData {
            errorMessage = "Invalid data received"
        } catch {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func selectCuisine(_ cuisine: String?) {
        selectedCuisine = cuisine
    }
    
    func retry() {
        Task { await fetchRecipes() }
    }
}

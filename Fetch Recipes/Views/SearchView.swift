//
//  SearchView.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/20/25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var vm: RecipeViewModel
    
    @State private var searchTerm = ""
    
    var filteredRecipes: [Recipe] {
        guard !searchTerm.isEmpty else { return vm.recipes }
        return vm.recipes.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    var allCuisines: [String] {
        let uniqueCuisines = Set(vm.recipes.map { $0.cuisine })
        return Array(uniqueCuisines).sorted()
    }
    
    func getRecipesPerCuisine(for cuisine: String) -> [Recipe] {
        return vm.recipes.filter { $0.cuisine == cuisine }
    }
    
    var recipeSuggestions: [Recipe] {
        if searchTerm.isEmpty {
            return Array(vm.recipes.prefix(10))
        } else {
            return vm.recipes
                .filter {
                    $0.name.localizedCaseInsensitiveContains(searchTerm) ||
                    $0.cuisine.localizedCaseInsensitiveContains(searchTerm)
                }
                .prefix(5)
                .map { $0 }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if searchTerm.isEmpty {
                    Text("Browse by Cuisine")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.all)
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 2) {
                            ForEach(allCuisines, id: \.self) { cuisine in
                                CuisineRow(cuisine: cuisine, recipes: getRecipesPerCuisine(for: cuisine))
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                    List(filteredRecipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeRow(recipe: recipe)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                DetailedRecipesView(recipe: recipe)
            }
        }
        .navigationTitle("Search")
        .searchable(text: $searchTerm, placement: .automatic, prompt: "Search recipes by name or cuisine")
        .searchSuggestions {
            ForEach(recipeSuggestions, id: \.id) { recipe in
                NavigationLink(value: recipe) {
                    RecipeRow(recipe: recipe)
                }
                .searchCompletion(recipe.name)
                .foregroundStyle(.black)
            }
        }
        .overlay {
            if ProcessInfo.processInfo.arguments.contains("UITestMode") {
                VStack {
                    TextField("", text: $searchTerm)
                        .accessibilityIdentifier("searchField")
                        .frame(height: 44)
                        .opacity(0.05)
                        .disabled(true)
                }
            }
        }
        .onAppear {
            print("Launch arguments: \(ProcessInfo.processInfo.arguments)")
        }
    }
}

#Preview {
    let vm = RecipeViewModel()
    
    return SearchView()
        .environmentObject(vm)
}

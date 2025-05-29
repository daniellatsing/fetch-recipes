//
//  RecipeServiceTests.swift
//  Fetch RecipesTests
//
//  Created by Daniella Tsing on 5/25/25.
//

import XCTest
@testable import Fetch_Recipes

final class RecipeServiceTests: XCTestCase {
    
    private var sut: RecipeService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RecipeService()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testRetrieveRecipesSuccessfully() async throws {
        let recipes = try await sut.getRecipes()
        
        XCTAssertFalse(recipes.isEmpty, "There should be some recipe data")
            
        if let checkFirstRecipeQuality = recipes.first {
            XCTAssertFalse(checkFirstRecipeQuality.name.isEmpty, "The recipe should have a name")
            XCTAssertFalse(checkFirstRecipeQuality.cuisine.isEmpty, "The recipe should specify the cuisine")
            XCTAssertNotNil(checkFirstRecipeQuality.id, "The recipe cannot be identified without a UUID")
        }
    }
    
    func testDecodeRecipesSuccessfully() async throws {
        let sample = """
        {
            "recipes": [
                {
                    "cuisine": "Malaysian",
                    "name": "Apam Balik",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                    "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                    "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                },
                {
                    "cuisine": "British",
                    "name": "Apple & Blackberry Crumble",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                    "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                    "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                }
            ]
        }
        """
        
        let sampleData = sample.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let recipeResponse = try decoder.decode(RecipeResponse.self, from: sampleData)
        
        XCTAssertEqual(recipeResponse.recipes.count, 2, "There should be 2 recipes")
        
        let firstRecipe = recipeResponse.recipes[0]
        XCTAssertEqual(firstRecipe.name, "Apam Balik")
        XCTAssertEqual(firstRecipe.cuisine, "Malaysian")
        XCTAssertEqual(firstRecipe.id, UUID(uuidString: "0c6ca6e7-e32a-4053-b824-1dbf749910d8"))
        XCTAssertEqual(firstRecipe.youtubeUrl, URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg"))
        
        let secondRecipe = recipeResponse.recipes[1]
        XCTAssertEqual(secondRecipe.name, "Apple & Blackberry Crumble")
        XCTAssertEqual(secondRecipe.cuisine, "British")
        XCTAssertEqual(secondRecipe.id, UUID(uuidString: "599344f4-3c5c-4cca-b914-2210e3b3312f"))
        XCTAssertEqual(secondRecipe.youtubeUrl, URL(string: "https://www.youtube.com/watch?v=4vhcOwVBDO4"))
    }
    
    func testNetworkErrorHandling() async throws {
        let mockService = MockRecipeService()
        mockService.shouldFail = true
        
        let result = await mockService.getRecipes()
        
        switch result {
        case .success:
            XCTFail("Test expected to fail but succeeded")
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }
    
    func testMalformedDataHandling() throws {
        let malformed = """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Apple Frangipan Tart",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
                    "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
                    "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
                }
            ]
        }
        """
        
        let malformedData = malformed.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        XCTAssertThrowsError(try decoder.decode(RecipeResponse.self, from: malformedData)) { error in
            XCTAssertTrue(error is DecodingError, "Throwing a DecodingError Here")
        }
    }
    
    func testEmptyDataHandling() async throws {
        let empty = """
        {
            "recipes": [
            ]
        }
        """
        
        let emptyData = empty.data(using: .utf8)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(RecipeResponse.self, from: emptyData!)
            XCTAssertTrue(decodedResponse.recipes.isEmpty, "Expected recipes list to be empty")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}

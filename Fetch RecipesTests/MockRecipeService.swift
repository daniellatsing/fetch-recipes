//
//  MockRecipeService.swift
//  Fetch RecipesTests
//
//  Created by Daniella Tsing on 5/28/25.
//

import XCTest
@testable import Fetch_Recipes

final class MockRecipeService: XCTestCase {
    var shouldFail = false

    func getRecipes() async -> Result<[Recipe], Error> {
        if shouldFail {
            return .failure(NSError(domain: "MockError", code: -1, userInfo: nil))
        } else {
            return .success([Recipe.mock()])
        }
    }

}

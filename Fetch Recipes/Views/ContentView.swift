//
//  ContentView.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @State var data = Recipe(cuisine: String, name: <#T##String#>, id: <#T##UUID#>, photoURLLarge: <#T##URL?#>, photoURLSmall: <#T##URL?#>, sourceURL: <#T##URL?#>, youtubeURL: <#T##URL?#>)
    
    var data: Recipe
    
    func getData() {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) {data, _, error in DispatchQueue.main.async {
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(Recipe.self, from: data)
                } catch {
                    print("Error! Something went wrong")
                }
            }
        }}.resume()
    }
    
    var body: some View {
//        if isActive {
//            HomeView()
//        } else {
//            SplashScreenView(onFinish: {
//                withAnimation {
//                    isActive = true
//                }
//            })
//        }
        VStack{
            Image("\(data.photoURLSmall)")
        }
    }
}

#Preview {
    ContentView(data)
}

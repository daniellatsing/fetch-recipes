//
//  TabBar.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/20/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
        }
        
    }
}

#Preview {
    TabBar()
}

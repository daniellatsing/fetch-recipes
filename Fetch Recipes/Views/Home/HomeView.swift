//
//  HomePageView.swift
//  Fetch Recipes
//
//  Created by Daniella Tsing on 5/16/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Discover")
                    .font(Font.custom("Katibeh", size: 48))
                    .padding(.horizontal, 24.0)
                    .padding(.top, 2.0)
                    .padding(.bottom, -22.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HomText("Today's recipes curated for you")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.davySGray)
                    .padding(.horizontal, 24.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: true) {
                    LazyHStack(alignment: .top, spacing: 18) {
                        ForEach(1...10, id: \.self) { count in
                            //                        AsyncImage(url: /*@START_MENU_TOKEN@*/URL(string: "https://example.com/icon.png")/*@END_MENU_TOKEN@*/)
                            VStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 14)
                                    .frame(width:280, height: 360)
                                
                                Text("Recipe Name")
                                    .font(.system(size: 18))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                
                                Text("Recipe Cuisine")
                            }
                            
                        }
                        
                    }
                }
                .padding(.leading, 24.0)
                
            }
            .padding(.top, 28.0)
            
            VStack {
                Text("Recent Recipes")
                    .font(Font.custom("Katibeh", size: 48))
                    .padding(.horizontal, 24)
                    .padding(.top, 2.0)
                    .padding(.bottom, -20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: true) {
                    LazyHStack(spacing: 18, content: {
                        ForEach(1...10, id: \.self) { count in
                            //                        AsyncImage(url: /*@START_MENU_TOKEN@*/URL(string: "https://example.com/icon.png")/*@END_MENU_TOKEN@*/)
                            HStack(alignment: .center) {
                                RoundedRectangle(cornerRadius: 14)
                                    .frame(width: 100, height: 100)
                                
                                VStack (alignment: .leading) {
                                    Text("Recipe Name")
                                        .font(.system(size: 18))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    
                                    Text("Recipe Cuisine")
                                }
                                .padding(.horizontal, 10.0)
                            }
                            .padding(.vertical, 8.0)
                            .padding(.horizontal, 8.0)
                            .background(Color.gray)
                            .cornerRadius(14.0)
                        }
                        
                    })
                }
                
            }
            
        }
        //        .overlay(
        //            TopNavigationBar(title: "Discover")
        //        )
    }
}

#Preview {
    HomeView()
}

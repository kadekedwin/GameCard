//
//  TabBar.swift
//  learn3
//
//  Created by Kadek Edwin on 24/08/23.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "list.bullet")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            
            
        }
    }
}

#Preview {
    TabBar().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

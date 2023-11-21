//
//  HomeView.swift
//  learn3
//
//  Created by Kadek Edwin on 24/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showAddView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView{
                    GameList()
                }
                .navigationTitle("My Game")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddView.toggle()
                        } label: {
                            Label("Add Game", systemImage: "plus.circle")
                        }
                    }
                }
                .sheet(isPresented: $showAddView) {
                    AddGameView()
                }
            }
            
        }
    }
}

#Preview {
    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

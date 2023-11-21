//
//  GameList.swift
//  learn3
//
//  Created by Kadek Edwin on 25/08/23.
//

import SwiftUI

struct GameList: View {
    let persistenceController = PersistenceController.shared
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Game.id, ascending: true)]) var games: FetchedResults<Game>
    
    @State private var selectedGame: Game? = nil
    
    var body: some View {
        VStack {
            
            HStack {
                Text("\(games.count) \(games.count > 1 ? "Games" : "Game" )")
                    .font(.headline)
                    .fontWeight(.regular)
                    .opacity(0.7)
                Spacer()
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 10)], spacing: 15) {
                ForEach(games) { game in
                    AsyncImage(url: URL(string: game.image!)) { image in
                        
                        NavigationLink(destination: GameDetailView()) {
                            
                            ZStack(alignment: .bottom) {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 160)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                VStack(alignment: .leading) {
                                    
                                    Text(game.name!)
                                        .font(.headline)
                                    
                                    HStack(spacing: 5) {
                                        Image(systemName: "gamecontroller")
                                        Text(game.category!)
                                    }
                                    .font(.caption)
                                    .bold()
                                    
                                    HStack() {
                                        Text(game.datePublished!)
                                            .font(.caption)
                                        
                                        Spacer()
                                        
                                        Button("Edit") {
                                            selectedGame = game
                                        }
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(.black)
                                        .frame(width: 60, height: 30)
                                        .background(Color.white)
                                        .cornerRadius(5)
                                        
                                    }
                                    
                                }
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 160, alignment: .leading)
                                .background(.ultraThinMaterial)
                                .cornerRadius(15)
                                
                            }
                            .frame(width: 160, height: 210)
                            .sheet(item: $selectedGame) { selectedGame in
                                EditGameView(game: selectedGame)
                            }
                            
                        }
                        
                    } placeholder: { Image(systemName: "photo") }
                        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 0)
                }
            }
            .padding(.vertical)
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    GameList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

//
//  EditGameView.swift
//  learn3
//
//  Created by Kadek Edwin on 25/08/23.
//

import SwiftUI

struct EditGameView: View {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    let game: FetchedResults<Game>.Element
    
    @State private var name = ""
    @State private var datePublished = ""
    @State private var image = ""
    @State private var desc = ""
    @State private var category = ""
    
    @State private var isValid = false
    
    var body: some View {
        NavigationView {
            
            Form() {
                Section {
                    TextField("\(game.name!)", text: $name)
                        .onAppear {
                            name = game.name!
                            datePublished = game.datePublished!
                            image = game.image!
                            desc = game.desc!
                            category = game.category!
                        }
                    TextField("\(game.datePublished!)", text: $datePublished)
                    TextField("\(game.image!)", text: $image)
                    TextField("\(game.desc!)", text: $desc)
                    TextField("\(game.category!)", text: $category)
                    
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button("Delete") {
                            persistenceController.deleteGame(
                                game: game,
                                context: viewContext
                            )
                            dismiss()
                        }
                        .foregroundColor(.red)
                        .bold()
                        Spacer()
                    }
                }
            }
            .foregroundColor(.black)
            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            .navigationBarTitle("Edit Game", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        persistenceController.editGame(
                            game: game,
                            name: name,
                            datePublished: datePublished,
                            image: image,
                            desc: desc,
                            category: category,
                            context: viewContext
                        )
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                    }
                }
            }
        }
        
    }
    
}

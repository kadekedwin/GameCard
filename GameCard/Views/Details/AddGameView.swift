//
//  AddView.swift
//  learn3
//
//  Created by Kadek Edwin on 25/08/23.
//

import SwiftUI

struct AddGameView: View {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var datePublished = ""
    @State private var image = ""
    @State private var desc = ""
    @State private var category = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Date Published", text: $datePublished)
                    TextField("Image", text: $image)
                    TextField("Description", text: $desc)
                    TextField("category", text: $category)
                    
                }
            }
            .navigationBarTitle("New Game", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        persistenceController.addGame(
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

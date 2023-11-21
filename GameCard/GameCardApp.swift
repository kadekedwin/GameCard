//
//  GameCardApp.swift
//  GameCard
//
//  Created by Kadek Edwin on 24/08/23.
//

import SwiftUI

@main
struct GameCardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBar()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

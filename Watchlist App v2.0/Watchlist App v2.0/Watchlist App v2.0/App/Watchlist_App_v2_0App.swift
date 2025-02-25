//
//  Watchlist_App_v2_0App.swift
//  Watchlist App v2.0
//
//  Created by Jad Kobrosly on 22/02/2025.
//

import SwiftUI
import SwiftData

@main
struct Watchlist_App_v2_0App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

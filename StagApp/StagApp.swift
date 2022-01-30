//
//  StagAppApp.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 15.08.2021.
//

import SwiftUI

@main
struct StagApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.getContext())
        }
    }
}

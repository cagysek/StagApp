//
//  StagAppApp.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 15.08.2021.
//

import SwiftUI

@main
struct StagApp: App {

    @AppStorage(UserDefaultKeys.LANGUAGE) private var language = Locale.current.languageCode ?? ELanguage.DEFAULT
    
    @State private var showAlert = false
    @State private var alertData = AlertData.empty
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.getContext())
                .environment(\.locale, .init(identifier: self.language == ELanguage.system.rawValue ? Locale.current.languageCode ?? ELanguage.DEFAULT : self.language))
            
                .onReceive(NotificationCenter.default.publisher(for: .showAlert)) { notif in
                    if let data = notif.object as? AlertData {
                        alertData = data
                        showAlert = true
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: alertData.title, message: alertData.msg, dismissButton: .default(Text("Ok")))
                }
        }
        
    }
}

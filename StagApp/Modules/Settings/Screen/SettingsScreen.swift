//
//  SettingsScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.04.2022.
//

import SwiftUI

struct SettingsScreen: View {
    
    @AppStorage(UserDefaultKeys.LANGUAGE) private var language = Locale.current.languageCode ?? ELanguage.DEFAULT
    
    @State var notificationsEnabled: Bool = false
    
    @State private var languageIndex: ELanguage = .system
    
    
    init () {
        self._languageIndex = State(initialValue: ELanguage.init(rawValue: language) ?? ELanguage.czech)
    }
    
    
    var body: some View {
     
        Form {
            
            Section(header: Text("settings.common")) {
                
                Picker(selection: $languageIndex, label: Text(LocalizedStringKey("settings.language"))) {
                    
                    HStack {
                        Text(ELanguage.system.localizedName)
                    }.tag(ELanguage.system)
                    
                    HStack {
                        Text("🇨🇿")
                        Text(ELanguage.czech.localizedName)
                    }.tag(ELanguage.czech)
                    
                    HStack {
                        Text("🇺🇸")
                        Text(ELanguage.english_us.localizedName)
                    }.tag(ELanguage.english_us)
                }
                .onChange(of: languageIndex) { selectedLanguage in
                    self.language = selectedLanguage.rawValue
                }
                
            }
            
        
            HStack {
                Text("settings.version")
                Spacer()
                Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
            }
            
            HStack {
                Text("settings.build")
                Spacer()
                Text(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "")
            }
                

            
        }
        .navigationTitle("settings.title".localized(language))
        
    }
    
}


struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}

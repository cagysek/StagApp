import SwiftUI

/// App screen `Settings`
struct SettingsScreen: View {
    
    @AppStorage(UserDefaultKeys.LANGUAGE) private var language = LanguageService.shared.language
    
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
                        Text("π¨πΏ")
                        Text(ELanguage.czech.localizedName)
                    }.tag(ELanguage.czech)
                    
                    HStack {
                        Text("πΊπΈ")
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

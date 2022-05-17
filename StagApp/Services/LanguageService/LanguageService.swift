//
//  LanguageService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 03.04.2022.
//

import Foundation


import Foundation

/// Singleton, which provides current app localization
class LanguageService {
    
    static let shared = LanguageService()
    
    
    private init() {}
    
    
    /// Returns code for current language
    var language: String {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: UserDefaultKeys.LANGUAGE) else {
                // if user default values is not set, set system locale
                return Locale.current.languageCode ?? ELanguage.DEFAULT
            }
            
            // if system language is set, loads system locale
            if (languageString == ELanguage.system.rawValue) {
                return Locale.current.languageCode ?? ELanguage.DEFAULT
            }
            
            return languageString
        } set {
            if (newValue != language) {
                UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.LANGUAGE)
            }
        }
    }
}

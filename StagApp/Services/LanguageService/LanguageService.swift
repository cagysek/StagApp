//
//  LanguageService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 03.04.2022.
//

import Foundation


//
//  LanguageService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.04.2022.
//

import Foundation

class LanguageService {
    
    static let shared = LanguageService()
    
    
    private init() {}
    
    var language: String {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: UserDefaultKeys.LANGUAGE) else {
                return ELanguage.DEFAULT
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
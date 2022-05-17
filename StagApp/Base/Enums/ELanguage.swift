//
//  ELanguage.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.04.2022.
//

import Foundation
import SwiftUI


/// Enum which defines languages in app
enum ELanguage: String, CaseIterable {
    
    public static let DEFAULT = "en"
    
    case system = "settings.default"
    case english_us = "en"
    case czech = "cs"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    
//    private func getFlag(language: String): String {
//
//    }
}

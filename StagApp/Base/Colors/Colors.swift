//
//  Colors.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation
import SwiftUI

extension Color {
    // MARK: Custom colors
    static let customBlue = Color(red: 35/255, green: 84/255, blue: 136/255, opacity: 1.0)
    static let customLightGray = Color(red: 229/255, green: 229/255, blue: 229/255, opacity: 1.0)
    static let customLightGreen = Color(red: 222/255, green: 255/255, blue: 232/255, opacity: 1.0)
    static let customLightRed = Color(red: 255/255, green: 233/255, blue: 233/255, opacity: 1.0)
    static let customDarkGray = Color(red: 213/255, green: 213/255, blue: 213/255, opacity: 1.0)
    
    // MARK: Background color definition
    static let defaultBackground = Color(red: 242/255, green: 244/255, blue: 245/255, opacity: 1.0)
    
    // MARK: Shadow color definition
    static let shadow = Color(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.1)
    
    // MARK: Forn color definition
    static let defaultFontColor = Color(red: 58/255, green: 62/255, blue: 68/255, opacity: 1.0)
}

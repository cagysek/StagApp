//
//  View+keyboard.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 03.04.2022.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

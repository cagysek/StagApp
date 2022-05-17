//
//  LoginTextFieldStyle.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.11.2021.
//

import Foundation
import SwiftUI


/// Custom style for login button
struct LoginTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .frame(height: 25)
            .padding()
            .background(.white)
            .font(.system(size: 18, weight: .regular, design: .rounded))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .shadow, radius: 8)
    }
}

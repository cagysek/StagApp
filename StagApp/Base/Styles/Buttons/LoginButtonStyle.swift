//
//  LoginButtonStyle.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.11.2021.
//

import Foundation
import SwiftUI


/// Definition of style for login button
struct LoginButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: UIScreen.main.bounds.width)
            .background(.white)
            .foregroundColor(.defaultFontColor)
            .font(.system(size: 24, weight: .semibold, design: .rounded))
            .clipShape(Capsule())
            .shadow(color: .shadow, radius: 8)
    }
}

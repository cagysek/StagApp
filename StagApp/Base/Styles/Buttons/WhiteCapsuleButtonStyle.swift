//
//  WhiteCapsuleButtonStyle.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.11.2021.
//

import Foundation
import SwiftUI


struct WhiteCapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white)
            .foregroundColor(.defaultFontColor)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .frame(height: 30)
            .clipShape(Capsule())
            .shadow(color: .shadow, radius: 8)
    }
}

//
//  CapsuleButton.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 07.11.2021.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.customBlue)
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .frame(height: 30)
            .clipShape(Capsule())
    }
}

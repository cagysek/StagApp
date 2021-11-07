//
//  BasicButtonStyle.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 07.11.2021.
//

import SwiftUI

struct BasicButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.customBlue)
            .font(.system(size: 16, weight: .bold, design: .rounded))
    }
}

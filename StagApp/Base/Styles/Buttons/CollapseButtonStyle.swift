//
//  CollapseButtonStyle.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 15.11.2021.
//

import SwiftUI


/// Definition of style for collapse buttons
struct CollapseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.white)
            .font(.system(size: 18, weight: .semibold, design: .rounded))
            .frame(height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


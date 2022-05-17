//
//  WhiteCapsuleButtonStyle.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.11.2021.
//

import Foundation
import SwiftUI


/// Definition of style for white capsule buttons
struct WhiteCapsuleButtonStyle: ButtonStyle {
    
    let fontSize: CGFloat

    public init(fontSize: CGFloat = 16) {
        self.fontSize = fontSize
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white)
            .foregroundColor(.defaultFontColor)
            .font(.system(size: self.fontSize, weight: .semibold, design: .rounded))
            .frame(height: self.fontSize * 2)
            .clipShape(Capsule())
            .shadow(color: .shadow, radius: 2)
    }
}

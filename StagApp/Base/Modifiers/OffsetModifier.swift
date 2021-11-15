//
//  OffsetModifier.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 12.11.2021.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
//                    print(minY)
                    DispatchQueue.main.async {
                        self.offset = -minY
                    }
                    
                    return Color.clear
                }
                , alignment: .top
            )
    }
}

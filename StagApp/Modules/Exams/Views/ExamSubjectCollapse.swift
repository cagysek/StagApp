//
//  ExamSubjectCollapse.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 18.11.2021.
//

import SwiftUI

struct ExamSubjectCollapse<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    @State var sections: CGFloat
    
    @State private var isCollapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(
                action: {
                    withAnimation(.easeIn(duration: 0.3)) {
                        self.isCollapsed.toggle()
                    }
                },
                label: {
                    HStack {
                        self.label()
                        Spacer()
                        Image(systemName: self.isCollapsed ? "chevron.down" : "chevron.up")
                    }
                    
                }
            )
            .buttonStyle(CollapseButtonStyle())
            .zIndex(2)
            
            
            VStack {
                self.content()
                    
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: self.isCollapsed ? 0 : (222 * self.sections))
            .clipped()
            .offset(y: -50)
            .padding(.bottom, -50)
            .allowsHitTesting(!self.isCollapsed)
            
        }
        
    }
}

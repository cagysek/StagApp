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
        LazyVStack {
            Button(
                action: {
                    withAnimation(.easeIn(duration: 0.2)) {
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
            .shadow(color: self.isCollapsed ? .shadow : .white, radius: self.isCollapsed ? 8 : 0)
            .zIndex(2)
            
            
            VStack {
                self.content()
                    
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: self.isCollapsed ? 0 : (222 * self.sections))
            .clipped()
            .offset(y: -50)
            .padding(.bottom, -50)
            .allowsHitTesting(!self.isCollapsed)
            .shadow(color: .shadow, radius: 8)
            
        }
        
    }
}

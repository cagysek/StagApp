//
//  ExamSubjectCollapse.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 18.11.2021.
//

import SwiftUI

/// Component of ``ExamsScreen``. Presents collapse component
struct ExamSubjectCollapse<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    @State var sections: Int
    
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
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: self.isCollapsed ? 0 : (400 * CGFloat(self.sections)))
            .clipped()
            .offset(y: -35) // moving collapse content up (button + VStack looks like one element)
            .padding(.bottom, -20) // moving next collapse up
            .allowsHitTesting(!self.isCollapsed)
            .shadow(color: .shadow, radius: 8)
        }
        
    }
}

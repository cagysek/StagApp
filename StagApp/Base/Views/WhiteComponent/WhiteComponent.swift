//
//  WhiteComponent.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.03.2022.
//

import SwiftUI


/// Presents basic white component with text
struct WhiteComponent: View {
    
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill()
                .foregroundColor(Color.white)
                .frame(height: 90)
                .shadow(color: Color.shadow, radius: 8)
            
            Text(LocalizedStringKey(text)).font(.system(size: 16, weight: .regular, design: .rounded))
        }
        .padding()
    }
}

struct WhiteComponent_Previews: PreviewProvider {
    static var previews: some View {
        WhiteComponent(text: "Text")
    }
}

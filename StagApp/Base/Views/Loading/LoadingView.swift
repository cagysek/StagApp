//
//  LoadingView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import SwiftUI

struct LoadingView: View {
    
    let text: String
    
    let withBackground: Bool
    
    var body: some View {
        Group {
            if (withBackground) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill()
                        .foregroundColor(Color.white)
                        .frame(height: 90)
                        .shadow(color: Color.shadow, radius: 8)
                    
                    VStack(spacing: 8) {
                        ProgressView()
                        Text(LocalizedStringKey(self.text))
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                    }
                }
                .padding()
            }
            else
            {
                VStack(spacing: 8) {
                    ProgressView()
                    Text(LocalizedStringKey(self.text))
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(text: "common.loading", withBackground: true)
    }
}

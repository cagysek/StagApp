//
//  AboutScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 06.04.2022.
//

import SwiftUI

struct AboutScreen: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.defaultBackground.ignoresSafeArea()
            
            InformationBubble {
                VStack(alignment: .leading) {
                    Text("about.text")
                        .font(.system(size: 15, weight: .regular , design: .rounded))
                        .padding(.bottom, 6)
                    
                    Text("about.contact")
                        .font(.system(size: 15, weight: .regular , design: .rounded))
                }
                .padding([.leading, .trailing])
            }
            .frame(height: 280)
            .padding()
            
            
            
        }
        .navigationTitle("about.title")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen()
    }
}

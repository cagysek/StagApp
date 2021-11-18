//
//  ExamsScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct ExamsScreen: View {
    var body: some View {
        
            
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            ScrollView(.vertical) {
            
            VStack {
                    HStack(alignment:.bottom) {
                        Text("Zkoušky")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            
                        Spacer()
                    }
                    
                
                    VStack(spacing: 10) {
                        
                        ExamSubjectCollapse(
                            label: { Text("KIV/FJP") },
                            content: {
                                ZStack(alignment: .top) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill()
                                            .foregroundColor(.white)
                                    VStack {
                                        ExamTermView()
                                        ExamTermView()
                                        ExamTermView()
                                        
                                    }
                                    .padding(.top, 40)
                                }
                                .frame(maxWidth: .infinity)
                                .shadow(color: .gray.opacity(0.1), radius: 10)
                                
                            },
                            sections: 3
                        )
                            
                        
                        ExamSubjectCollapse(
                            label: { Text("KIV/UPS") },
                            content: {
                                ZStack(alignment: .top) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill()
                                            .foregroundColor(.white)
                                    VStack {
                                        ExamTermView()
                                        ExamTermView()
                                        
                                    }
                                    .padding(.top, 40)
                                }
                                .frame(maxWidth: .infinity)
                                .shadow(color: .gray.opacity(0.1), radius: 10)
                                
                            },
                            sections: 2
                        )
                    }
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                    
            }
        }
    }
        
}

struct ExamsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExamsScreen()
    }
}

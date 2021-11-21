//
//  OverviewScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import SwiftUI

struct OverviewScreen: View {
    
    @Binding var selectedTabIndex: Int
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            
            
                VStack {
                    HStack(alignment:.bottom) {
                        Text("Přehled")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                        
                        Spacer()
                        
                        Text("01.09.2021")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        
                        Text("sudý týden")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                        
                    }
                    .padding()
                    
                    
                    ZStack(alignment: .top) {
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .padding([.leading, .trailing])
                            
                        VStack {
                            HStack(alignment: .bottom) {
                                Text("Dnešní rozvrh (3)")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                
                                Spacer()
                                
                                Button("Zobrazit vše") {
                                    self.selectedTabIndex = 0
                                }
                                .buttonStyle(BasicButtonStyle())
                            }
                            .padding(.trailing, 30)
                            .padding(.leading, 30)
                            .padding(.bottom, 10)
                        
                        
                            OverviewSubjectCell(backgroundColor: .customLightGreen)
                        
                            OverviewSubjectCell(backgroundColor: .customDarkGray)
                        
                        }
                        .padding(.top, 15)
                        
                        
                    }
                    .frame(height: 292)
                    .shadow(color: Color.shadow, radius: 4)
                    
                    
                    
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .padding([.leading, .trailing])
                            
                        VStack {
                            HStack(alignment: .bottom) {
                                Text("Připomínky (6)")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                
                                Spacer()
                                
                                Button("Zobrazit vše") {
                                    
                                }
                                .buttonStyle(BasicButtonStyle())
                            }
                            .padding(.trailing, 30)
                            .padding(.leading, 30)
                            .padding(.bottom, 10)
                        
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    OverviewNoteCell(backgroundColor: Color.customLightRed)
                                    OverviewNoteCell(backgroundColor: Color.customLightGreen)
                                    OverviewNoteCell(backgroundColor: Color.customLightRed)
                                    OverviewNoteCell(backgroundColor: Color.customLightGreen)
                                }
                            }
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                            .padding(.bottom, 15)
                            
                            
                            HStack {
                                Spacer()
                                Button("+ Přidat") {
                                    
                                }
                                .buttonStyle(BasicButtonStyle())
                            }
                            .padding(.trailing, 30)
                            .padding(.bottom, 15)
                            
                        
                        }
                        .padding(.top, 15)
                        
                        
                    }
                    .frame(height: 260)
                    .shadow(color: Color.shadow, radius: 4)
                    .padding(.top)
                    
                    
                    Spacer()
                
            }
        }
        .foregroundColor(.defaultFontColor)
        
    }
}


struct OverviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        OverviewScreen(selectedTabIndex: .constant(0))
    }
}

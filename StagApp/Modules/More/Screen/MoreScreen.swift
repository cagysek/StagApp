//
//  MoreScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct MoreScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color
                    .defaultBackground
                    .ignoresSafeArea()
                
                VStack {
                    HStack(alignment:.bottom) {
                        Text("Další")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                        Spacer()
                    }
                    .padding()
                    
                    
                    List {
                        Section(header: Text("ZČU").font(.system(size: 14, weight: .medium, design: .rounded))) {
                            NavigationLink {
                                DietScreen()
                            } label: {
                                Text("Jídelníček")
                            }
                            
                            NavigationLink {
                                DietScreen()
                            } label: {
                                Text("Webmail")
                            }
                            
                            
                        }

                        Section() {
                            NavigationLink {
                                DietScreen()
                            } label: {
                                Text("Učebny")
                            }
                            
                            NavigationLink {
                                DietScreen()
                            } label: {
                                Text("Nastavení")
                            }
                            
                            
                        }
                        
                        
                        Text("Odhlásit se")
                    }
                    .listStyle(.grouped)
                    .listSectionSeparator(.hidden, edges: .all)
                    .padding(.top, -20)
                    
                    
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
        
    }
}

struct MoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        MoreScreen()
    }
}

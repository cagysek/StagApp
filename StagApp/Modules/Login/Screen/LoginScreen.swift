//
//  LoginScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import SwiftUI

struct LoginScreen: View {
    
    @Binding var isLogged : Bool
    @Binding var university: University?
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State var showUniversity: Bool = false
    
    @StateObject private var vm = LoginViewModelImpl(
        stagService: StagService()
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                Color
                    .defaultBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: UniversityScreen(showUniversity: self.$showUniversity, selectedUniversity: self.$university), isActive: $showUniversity) {
                            Button("Změnit univerzitu", action: {
                                withAnimation {
                                    self.showUniversity = true
                                }
                            })
                            .buttonStyle(WhiteCapsuleButtonStyle())
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            
                            .foregroundColor(Color.customBlue)
                            .padding(.trailing, 25)
                        }
                        
                    }
                    
                    Image(self.university?.bigLogoImagePath ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.size.width * 0.80 , height: UIScreen.main.bounds.size.height * 1/6)
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                        
                    
                    
                    Text("Přihlášení")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    Text("Pro pokračování se prosím přihlašte")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundColor(.gray)
                        .padding()
                        
                    
                    TextField(
                            "Email",
                             text: $username
                    )
                    .textFieldStyle(LoginTextFieldStyle())
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    
                    SecureField(
                            "Heslo",
                             text: $password
                    )
                    .textFieldStyle(LoginTextFieldStyle())
                    .padding(20)
                    
                    
                    Button("Přihlásit se", action: {
                        withAnimation(.easeOut(duration: 0.4)) {
                            self.isLogged.toggle()
                        }
                        
                    })
                    .buttonStyle(LoginButtonStyle())
                    .padding(.leading)
                    .padding(.trailing)
                    
                    
                    
                    Spacer()
                    
                }
            }
            .foregroundColor(.defaultFontColor)
            .navigationBarHidden(true)
            .onAppear {
                self.showUniversity = self.university === nil
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    
    @State static var university: University?
    
    static var previews: some View {
        LoginScreen(isLogged: .constant(false), university: $university)
    }
}

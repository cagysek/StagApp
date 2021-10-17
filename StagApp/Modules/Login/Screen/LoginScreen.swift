//
//  LoginScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @StateObject private var vm = LoginViewModelImpl(
        stagService: StagServiceImpl()
    )
    
    var body: some View {
        VStack(spacing: 0) {
            
            Button("Změnit univerzitu", action: {
                
            })
            .font(.system(size: 14, weight: .regular, design: .rounded))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundColor(Color.customBlue)
            .padding(.trailing, 25)
                
            
            
            
            Image("zcu-logo-2")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.bottom, 50)
                
            
            
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
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 200,height: 50)
                    .foregroundColor(Color.customBlue)
                
                Button("PŘIHLÁSIT SE", action: {
                    
                })
                
                .foregroundColor(Color.white)
                .font(.system(size: 16, weight: .medium, design: .rounded))
            }
            
            Spacer()
            
        }
        
    }
}

struct LoginTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .frame(height: 25)
            .padding()
            .background(Color.customLightGray)
            .cornerRadius(5)
            .font(.system(size: 18, weight: .regular, design: .rounded))
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

//
//  ExamTermView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 18.11.2021.
//

import SwiftUI

struct ExamTermView: View {
    
    var isAvailable: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 8)
                .padding(.leading)
                .padding(.trailing)
                .foregroundColor(self.isAvailable ? .customLightBlue : .customLightRed)
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Zkouška")
                    .font(.system(size: 15, weight: .light, design: .rounded))
                Text("30.06.2021 ∙ 07:20 - 10:20")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Label("Doc. Ing. Přemysl Brada", systemImage: "person")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                Label {
                    Text("UP-120")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                } icon: {
                    Image("symbol-pin-2")
                        .resizable()
                        .frame(width: 17, height: 17)
                }
                
                Label("Zápis od ∙ 30.06.2021 ∙ 07:20", systemImage: "clock.badge.checkmark")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                
                Label("Zápis do ∙ 30.06.2021 ∙ 07:20", systemImage: "clock.badge.exclamationmark")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                
                
                HStack {
                    Label("Obsazenost 1/10", systemImage: "person.2.circle")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    
                    
                    Spacer()
                    
                    Button(self.isAvailable ? "Přihlásit se" : "Nelze se zapsat", action: {
                        print("přihlasit")
                    })
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                }
            }
            .padding()
            .padding(.leading)
            .padding(.trailing)
        }
        .frame(height: 180)
        .padding(.bottom)
    }
}

struct ExamTermView_Previews: PreviewProvider {
    static var previews: some View {
        ExamTermView()
    }
}

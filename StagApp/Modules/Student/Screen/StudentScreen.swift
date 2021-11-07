//
//  StudentScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct StudentScreen: View {
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            
            VStack {
                HStack(alignment: .bottom) {
                    Text("Student")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .padding(.leading, 20)
                        .padding(.bottom, -18)
                    
                    Spacer()
                }
                
                
                StudentInfoView()
                    
                YearsScrollView()
                
                YearSubjectsView()
            }
        }
    }
}

struct StudentScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentScreen()
    }
}





//
//  StudentInfoView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.10.2021.
//

import SwiftUI

struct StudentInfoView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .padding()
            
            VStack {
                Text("Bc. Jan Čarnogurský")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .padding(.bottom, 5)
                
                HStack {
                    Spacer()
                    StatisticLabelView(label: "Kredity", value: "55/120")
                    Spacer()
                    StatisticLabelView(label: "Průměr", value: "2.12")
                    Spacer()
                    StatisticLabelView(label: "Ročník", value: "3.")
                    Spacer()
                }
                
            }
        }
        .frame(height: 150)
        .shadow(color: Color.shadow, radius: 4)
    }
}

struct StudentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StudentInfoView()
    }
}

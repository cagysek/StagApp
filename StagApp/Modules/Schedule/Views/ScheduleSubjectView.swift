//
//  ScheduleSubjectView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.11.2021.
//

import SwiftUI

struct ScheduleSubjectView: View {
    var isExercise : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("08:25 - 10:00")
                Spacer()
                Text("1 h 45 min")
            }
            .font(.system(size: 14, weight: .bold, design: .rounded))
            
            ZStack(alignment: .topLeading) {
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(self.isExercise ? .customLightGreen : .customDarkGray)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(self.isExercise ? "Cvičení" : "Přednáška")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                    Text("Architektury softwarových systémů")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Text("KIV/SAR")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
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
                    
                }
                .padding()
            }
            .shadow(color: .shadow, radius: 10)
        }
        .frame(height: 175)
        .padding()
        .padding(.bottom, -15)
        
        
    }
}
struct ScheduleSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleSubjectView()
    }
}

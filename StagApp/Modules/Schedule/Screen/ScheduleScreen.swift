//
//  ScheduleScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct ScheduleScreen: View {
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            
            VStack {
                HStack(alignment:.bottom) {
                    Text("Rozvrh")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    Spacer()
                }
                .padding()
                
                VStack {
                    ScheduleDateTimeFilterView()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ScheduleSubjectView()
                            ScheduleSubjectView(isExercise: true)
                            ScheduleSubjectView()
                            ScheduleSubjectView()
                            ScheduleSubjectView()
                            ScheduleSubjectView()
                        }
                        .padding(.bottom, 30)
                        
                    }
                    .padding(.leading, -15)
                    .padding(.trailing, -15)
                    .padding(.bottom, -15)
                    
                }
                .padding(.leading)
                .padding(.trailing)
            }
        }
        
        .foregroundColor(.defaultFontColor)
    }
}

struct ScheduleScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleScreen()
    }
}


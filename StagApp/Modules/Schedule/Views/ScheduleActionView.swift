//
//  ScheduleSubjectView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.11.2021.
//

import SwiftUI

struct ScheduleActionView: View {
    
    var scheduleAction: ScheduleAction
    
    var isExercise : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(scheduleAction.getTimeOfAction())
                Spacer()
                Text(scheduleAction.getDuration())
            }
            .font(.system(size: 14, weight: .bold, design: .rounded))
            
            ZStack(alignment: .topLeading) {
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(scheduleAction.getBackgroundColor())
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(scheduleAction.label)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                    Text(scheduleAction.title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Text("\(scheduleAction.department)/\(scheduleAction.titleShort)")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    Label(scheduleAction.teacher?.getFormattedName() ?? "-", systemImage: "person")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    
                    Label {
                        Text("\(scheduleAction.building ?? "")-\(scheduleAction.room ?? "")")
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
//struct ScheduleSubjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleActionView(scheduleAction: ScheduleAction())
//    }
//}

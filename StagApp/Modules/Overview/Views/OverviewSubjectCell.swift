//
//  OverviewSibjectCell.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 07.11.2021.
//

import SwiftUI

struct OverviewSubjectCell: View {
    
    var scheduleAction: ScheduleAction
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(scheduleAction.getBackgroundColor())
            
            HStack(spacing: 0) {
                VStack(alignment: .center) {
                    Text(scheduleAction.timeFrom?.value ?? "")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                    
                    Text("-")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                    
                    Text(scheduleAction.timeTo?.value ?? "")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                }
                .frame(width: 65)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(scheduleAction.title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .truncationMode(.tail)
                    Label(scheduleAction.teacher?.getFormattedName() ?? "", systemImage: "person")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .truncationMode(.tail)
                    Label {
                        Text("\(scheduleAction.building ?? "")-\(scheduleAction.room ?? "")")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    } icon: {
                        Image("symbol-pin-2")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .padding()
                
                Spacer()
            }
            
        }
        .padding(.trailing, 30)
        .padding(.leading, 30)
        .frame(height: 100)
        .padding(.bottom, 10)
    }
}

//struct OverviewSibjectCell_Previews: PreviewProvider {
//    static var previews: some View {
//        OverviewSubjectCell(backgroundColor: .customLightGreen)
//    }
//}

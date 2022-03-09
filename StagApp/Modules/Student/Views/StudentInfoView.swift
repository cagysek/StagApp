//
//  StudentInfoView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.10.2021.
//

import SwiftUI

struct StudentInfoView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Student.entity(), sortDescriptors: []
    ) var student: FetchedResults<Student>
    
    @Binding var studentInfoData: Student?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .padding()
                .padding(.top, -15)
            
            VStack {
//                Text(self.studentInfoData?.getStudentFullNameWithTitles() ?? "")
                Text(self.student.first?.getStudentFullNameWithTitles() ?? "")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .padding(.bottom, 5)
                
                HStack {
                    Spacer()
                    StatisticLabelView(label: "student.stat-credits", value: "55/120")
                    Spacer()
                    StatisticLabelView(label: "student.stat-avg", value: "2.12")
                    Spacer()
                    StatisticLabelView(label: "student.stat-year", value: "3.")
                    Spacer()
                }
                
            }
        }
        .frame(height: 150)
        .shadow(color: Color.shadow, radius: 4)
    }
}
//
//struct StudentInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentInfoView(new ())
//    }
//}

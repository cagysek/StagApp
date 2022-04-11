//
//  StudentInfoView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.10.2021.
//

import SwiftUI

struct StudentInfoView: View {
//    @Environment(\.managedObjectContext) var managedObjectContext
//    
//    @FetchRequest(
//        entity: Student.entity(), sortDescriptors: []
//    ) var student: FetchedResults<Student>
    
    @Binding var studentInfoData: Student?
    
    var statistics: SubjectStatistics
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .padding([.leading,.trailing])
//                .padding(.top, -15)
            
            VStack {
                Text(self.studentInfoData?.getStudentFullNameWithTitles() ?? "")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .padding(.bottom, 5)
                
                HStack {
                    Text(StringHelper.concatStringsToOne(strings: self.studentInfoData?.studentId ?? "", self.studentInfoData?.email ?? ""))
                        .font(.system(size: 15, weight: .light, design: .rounded))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text(StringHelper.concatStringsToOne(strings: self.studentInfoData?.faculty ?? "", self.studentInfoData?.studyProgram ?? ""))
                        .font(.system(size: 15, weight: .light, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 5)
                
                HStack {
                    Spacer()
                    StatisticLabelView(label: "student.stat-credits", value: "\(String(self.statistics.getCurrentCredits()))/\(String(self.studentInfoData?.getTotalCreditCount() ?? 0))")
                    Spacer()
                    StatisticLabelView(label: "student.stat-avg", value: self.statistics.getAverageString())
                    Spacer()
                    StatisticLabelView(label: "student.stat-year", value: "\(self.studentInfoData?.studyYear ?? "").       ")
                    Spacer()
                }
            }
            .padding([.leading, .trailing])
        }
        .frame(height: 180)
        .shadow(color: Color.shadow, radius: 4)
    }
}
//
//struct StudentInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentInfoView(new ())
//    }
//}

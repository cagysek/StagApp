//
//  YearSubjectView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.10.2021.
//

import SwiftUI


struct YearSubjectsView: View {
    
    @Binding var winterSubjects: [Subject]
    @Binding var summerSubjects: [Subject]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .padding()
                    
                    VStack {
                        HStack {
                            Spacer()
                            StatisticLabelView(label: "student.stat-credits", value: "55/120")
                            Spacer()
                            StatisticLabelView(label: "student.stat-avg", value: "2.12")
                            Spacer()
                            StatisticLabelView(label: "student.stat-done", value: "2/10")
                            Spacer()
                        }
                        
                    }
                }
                .frame(height: 100)
                .shadow(color: Color.shadow, radius: 4)
                
                
                Text("student.winter-semester")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding(.leading, 20)
                    .padding(.bottom, -18)
                
                ForEach(self.$winterSubjects, id: \.self) { subject in
                    SubjectResultView(subject: subject)
                }
                
                Text("student.summer-semester")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding(.leading, 20)
                    .padding(.bottom, -18)
                    .padding(.top, 25)
                
                ForEach(self.$summerSubjects, id: \.self) { subject in
                    SubjectResultView(subject: subject)
                }

            }
            .padding(.bottom, 20)
        }
    }
}


//struct YearSubjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        YearSubjectsView()
//    }
//}

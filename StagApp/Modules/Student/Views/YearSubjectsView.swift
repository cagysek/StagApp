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
    @Binding var statistics: SubjectStatistics?
    @Binding var selectedYear: Int
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .padding([.trailing, .leading])
                        
                        VStack {
                            HStack {
                                Spacer()
                                StatisticLabelView(label: "student.stat-credits", value: "\(statistics?.getCurrentCredits() ?? 0)/\(statistics?.getTotalCredits() ?? 0)")
                                Spacer()
                                StatisticLabelView(label: "student.stat-avg", value: statistics?.getAverageString() ?? "-")
                                Spacer()
                                StatisticLabelView(label: "student.stat-done", value: "\(statistics?.getCompletedSubjects() ?? 0)/\(statistics?.getTotalSubjects() ?? 0)")
                                Spacer()
                            }
                        }
                        .padding()
                    }
                    .shadow(color: Color.shadow, radius: 4)
                    .id(1)
                    
                    
                    
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
            .onChange(of: selectedYear) { newValue in
                
                // reset scroll to top of scroll view
                withAnimation {
                    proxy.scrollTo(1)
                }
                
            }
        }
    }
}


//struct YearSubjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        YearSubjectsView()
//    }
//}

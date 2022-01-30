//
//  YearSubjectView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.10.2021.
//

import SwiftUI


struct YearSubjectsView: View {
    
    @Binding var subjectResults: [SubjectResult]
    
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
                            StatisticLabelView(label: "Kredity", value: "55/120")
                            Spacer()
                            StatisticLabelView(label: "Průměr", value: "2.12")
                            Spacer()
                            StatisticLabelView(label: "Splněno", value: "2/10")
                            Spacer()
                        }
                        
                    }
                }
                .frame(height: 100)
                .shadow(color: Color.shadow, radius: 4)
                
                
                Text("Zimní semestr")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding(.leading, 20)
                    .padding(.bottom, -18)
                
                ForEach(self.$subjectResults, id: \.self) { subjectResult in
                    SubjectResultView(subjectResult: subjectResult)
                }
                
//                SubjectResultView()
//                SubjectResultView()
//                SubjectResultView()
                
                Text("Letní semestr")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding(.leading, 20)
                    .padding(.bottom, -18)
                    .padding(.top, 25)
                
//                SubjectResultView()
//                SubjectResultView()
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

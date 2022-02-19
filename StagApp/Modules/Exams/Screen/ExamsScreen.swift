//
//  ExamsScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct ExamsScreen: View {
    
    @ObservedObject var vm = ExamsViewModel(stagService: StagService())
    
//    @ObservedObject var data: [String: [Exam]]
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            ScrollView(.vertical) {
            
            VStack {
                    HStack(alignment:.bottom) {
                        Text("Zkoušky")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            
                        Spacer()
                    }
                    
                
                    VStack(spacing: 10) {
                        
                        ForEach(Array(self.vm.exams), id: \.key) { subject, exams in
                            ExamSubjectCollapse(
                                label: { Text("\(exams.first!.department)/\(exams.first!.subject) (\(exams.count))") },
                                content: {
                                    ZStack(alignment: .top) {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill()
                                                .foregroundColor(.white)
                                        VStack {
                                            ForEach(exams, id: \.id) { exam in
                                                ExamTermView(exam: exam, vm: self.vm)
                                            }
                                        }
                                        .padding(.top, 40)
                                    }
                                    .frame(maxWidth: .infinity)


                                },
                                sections: exams.count
                            )
                        }
                    }
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .task {
                    await vm.loadExams()
                }
                    
            }
        }
        .foregroundColor(.defaultFontColor)
    }
        
}

struct ExamsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExamsScreen()
    }
}

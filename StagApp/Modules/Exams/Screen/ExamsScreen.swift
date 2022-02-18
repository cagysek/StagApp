//
//  ExamsScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct ExamsScreen: View {
    
    @StateObject var vm = ExamsViewModel(stagService: StagService())
    
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
                                                ExamTermView(exam: exam)
                                            }


                                        }
                                        .padding(.top, 40)
                                    }
                                    .frame(maxWidth: .infinity)


                                },
                                sections: exams.count
                            )
                        }
                        
                        
                            
                        
//                        ExamSubjectCollapse(
//                            label: { Text("KIV/UPS (2)") },
//                            content: {
//                                ZStack(alignment: .top) {
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .fill()
//                                            .foregroundColor(.white)
//                                    VStack {
//                                        ExamTermView(isAvailable: true)
//                                        ExamTermView()
//
//                                    }
//                                    .padding(.top, 40)
//                                }
//                                .frame(maxWidth: .infinity)
//
//
//                            },
//                            sections: 2
//                        )
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

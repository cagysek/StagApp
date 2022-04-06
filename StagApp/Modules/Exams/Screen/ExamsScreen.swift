//
//  ExamsScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct ExamsScreen: View {
    
    @StateObject var vm: ExamsViewModel
    
    init() {
        self._vm = StateObject(wrappedValue: ExamsViewModel(stagService: StagService(), studentRepository: StudentRepository(context: CoreDataManager.getContext()), keychainManager: KeychainManager()))
    }
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            ScrollView(.vertical) {
            
            VStack {
                    HStack(alignment:.bottom) {
                        Text("exam.headline")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            
                        Spacer()
                    }
                    
                
                    VStack(spacing: 10) {
                        
                        switch self.vm.state {
                        case .idle:
                            if (!self.vm.exams.isEmpty) {
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
                            else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill()
                                        .foregroundColor(Color.white)
                                        .frame(height: 90)
                                        .shadow(color: Color.shadow, radius: 8)
                                    
                                    Text("exam.no-exams").font(.system(size: 16, weight: .regular, design: .rounded))
                                }
                            }
                        case .fetchingData:
                            LoadingView(text: "common.loading", withBackground: true)
                                
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

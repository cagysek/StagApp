//
//  StudentScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct StudentScreen: View {
    
    @StateObject var vm = StudentInfoViewModelImpl(stagService: StagServiceImpl())
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            
            VStack {
                HStack(alignment: .bottom) {
                    Text("Student")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    Spacer()
                }
                .padding()
                
                
                StudentInfoView(studentInfoData: self.$vm.studentInfo)
                    
                YearsScrollView()
                
                YearSubjectsView(subjectResults: self.$vm.examResults)
            }
        }
        .foregroundColor(.defaultFontColor)
        .onAppear {
            vm.getUserData()
        }
        .task {
            do {
//                try await vm.getUserData()
            } catch {
                print(error)
            }
        }
    }
}

struct StudentScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentScreen()
    }
}





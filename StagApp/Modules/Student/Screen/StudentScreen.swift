//
//  StudentScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct StudentScreen: View {
    
    @StateObject var vm = StudentInfoViewModel(stagService: StagService(), subjectRepository: SubjectRepository(context: CoreDataManager.getContext()))
    
    @State var studyYears: Array<Int> = []
    
    @State var selectedYear: Int = 0
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            
            VStack {
                HStack(alignment: .bottom) {
                    Text("student.headline")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    Spacer()
                }
                .padding()
                
                
                StudentInfoView(studentInfoData: self.$vm.studentInfo)
                    
                YearsScrollView(selectedYear: self.$selectedYear, studyYears: self.studyYears, vm: vm)
                
                YearSubjectsView(winterSubjects: self.$vm.winterSubjects, summerSubjects: self.$vm.summerSubjects)
            }
        }
        .foregroundColor(.defaultFontColor)
        .onAppear {
            
            
            self.studyYears = vm.getStudyYears()
            
            if self.selectedYear == 0 {
                if !studyYears.isEmpty {
                    self.selectedYear = studyYears.first!
                }
                
            }
            
            vm.getUserData()
            vm.updateSubjectData(year: selectedYear)
        }
    }
}

struct StudentScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentScreen(studyYears: [], selectedYear: 1)
    }
}





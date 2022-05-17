import SwiftUI

/// App screen `Student`
struct StudentScreen: View {
    
    @ObservedObject var vm = StudentInfoViewModel(dataManager: DataManager(stagApiService: StagService(), subjectRepository: SubjectRepository(context: CoreDataManager.getContext()), teacherRepository: TeacherRepository(context: CoreDataManager.getContext())), subjectRepository: SubjectRepository(context: CoreDataManager.getContext()), subjectStatisticsCalculator: SubjectStatisticsCalculator())
    
    @State var studyYears: Array<Int> = []
    
    @State var selectedYear: Int = 0
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack(alignment: .bottom) {
                        Text("student.headline")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                        
                        Spacer()
                    }
                    .padding([.leading, .top, .trailing])
                    
                    
                    StudentInfoView(studentInfoData: self.$vm.studentInfo, statistics: self.vm.getTotalStatistics())
                        
                    YearsScrollView(selectedYear: self.$selectedYear, studyYears: self.studyYears, vm: vm)
                        .padding([.bottom, .top])
                    
                    YearSubjectsView(winterSubjects: self.$vm.winterSubjects, summerSubjects: self.$vm.summerSubjects, statistics: self.$vm.yearStatistics, selectedYear: self.$selectedYear)
                }
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





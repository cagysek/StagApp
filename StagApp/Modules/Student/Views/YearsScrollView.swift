import SwiftUI

/// Component of ``StudentScreen``. Allow select study year
struct YearsScrollView: View {
    
    @Binding var selectedYear: Int
    
    
    var studyYears: Array<Int>
    
    var vm: StudentInfoViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                
                ForEach(studyYears, id: \.self) { studyYear in
                    Button(self.getDisplayYear(year: studyYear), action: {
                        self.selectedYear = studyYear;
                        
                        DispatchQueue.main.async {
                            vm.updateSubjectData(year: studyYear)
                        }
                    })
                    .foregroundColor(Color.white)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .if(self.selectedYear == studyYear) { $0.buttonStyle(BlueCapsuleButtonStyle()) }
                    .if(self.selectedYear != studyYear) { $0.buttonStyle(WhiteCapsuleButtonStyle()) }
                }
            }
        }
        .padding([.leading, .trailing])
    }
    
    
    private func getDisplayYear(year: Int) -> String {
        let nextYearString = String(year + 1)
        let nextYearSuffix = nextYearString.suffix(2)
        
        return "\(year)/\(nextYearSuffix)"
    }

    
}

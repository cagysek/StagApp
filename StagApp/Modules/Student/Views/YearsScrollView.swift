//
//  YearsScrollView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.10.2021.
//

import SwiftUI

struct YearsScrollView: View {
    
    @Binding var selectedYear: Int
    
    
    var studyYears: Array<Int>
    
    var vm: StudentInfoViewModelImpl
    
    var body: some View {
        ScrollView(.horizontal) {
            
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
            .padding()
        }
        
        .padding(.bottom, -15)
        .padding(.top, -15)
    }
    
    
    private func getDisplayYear(year: Int) -> String {
        let nextYearString = String(year + 1)
        let nextYearSuffix = nextYearString.suffix(2)
        
        return "\(year)/\(nextYearSuffix)"
    }

    
}

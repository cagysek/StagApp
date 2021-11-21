//
//  YearsScrollView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.10.2021.
//

import SwiftUI

struct YearsScrollView: View {
    
    @State var selectedYear: Int = 1;
    
    var body: some View {
        ScrollView(.horizontal) {
            
            HStack {
                Button("2021/22", action: {
                    self.selectedYear = 1;
                })
                .foregroundColor(Color.white)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .if(self.selectedYear == 1) { $0.buttonStyle(BlueCapsuleButtonStyle()) }
                .if(self.selectedYear != 1) { $0.buttonStyle(WhiteCapsuleButtonStyle()) }
                
                
                Button("2020/21", action: {
                    self.selectedYear = 2;
                })
                .foregroundColor(Color.white)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .if(self.selectedYear == 2) { $0.buttonStyle(BlueCapsuleButtonStyle()) }
                .if(self.selectedYear != 2) { $0.buttonStyle(WhiteCapsuleButtonStyle()) }
                
                Button("2019/20", action: {
                    self.selectedYear = 3;
                })
                .foregroundColor(Color.white)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .if(self.selectedYear == 3) { $0.buttonStyle(BlueCapsuleButtonStyle()) }
                .if(self.selectedYear != 3) { $0.buttonStyle(WhiteCapsuleButtonStyle()) }
            }
            .padding()
        }
        
        .padding(.bottom, -15)
        .padding(.top, -15)
    }

    
}




struct YearsScrollView_Previews: PreviewProvider {
    static var previews: some View {
        YearsScrollView()
    }
}

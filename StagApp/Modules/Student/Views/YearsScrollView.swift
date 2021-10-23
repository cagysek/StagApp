//
//  YearsScrollView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.10.2021.
//

import SwiftUI

struct YearsScrollView: View {
    var body: some View {
        ScrollView(.horizontal) {
            
            HStack {
                Button("2021/22", action: {
                    
                })
                    .foregroundColor(Color.white)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .buttonStyle(BlueButton())
                
                Button("2020/21", action: {
                    
                })
                    .foregroundColor(Color.white)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .buttonStyle(BlueButton())
                
                Button("2019/20", action: {
                    
                })
                    .foregroundColor(Color.white)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .buttonStyle(BlueButton())
            }
        }
        .padding(.trailing, 20)
        .padding(.leading, 20)
        .padding(.bottom, 5)
    }
}

fileprivate struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.customBlue)
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .frame(height: 30)
            .clipShape(Capsule())
    }
}


struct YearsScrollView_Previews: PreviewProvider {
    static var previews: some View {
        YearsScrollView()
    }
}

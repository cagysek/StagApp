//
//  OverviewSibjectCell.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 07.11.2021.
//

import SwiftUI

struct OverviewSubjectCell: View {
    
    let backgroundColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(self.backgroundColor)
            
            HStack(spacing: 0) {
                VStack(alignment: .center) {
                    Text("07:20")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                }
                .frame(width: 65)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Architektury softwarových systémů")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .scaledToFit()
                    Label("Doc. Ing. Přemysl Brada", systemImage: "person")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .scaledToFit()
                    Label {
                        Text("UP-120")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    } icon: {
                        Image("symbol-pin-2")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .padding()
            }
            
        }
        .padding(.trailing, 30)
        .padding(.leading, 30)
        .frame(height: 100)
        .padding(.bottom, 10)
    }
}

struct OverviewSibjectCell_Previews: PreviewProvider {
    static var previews: some View {
        OverviewSubjectCell(backgroundColor: .customLightGreen)
    }
}

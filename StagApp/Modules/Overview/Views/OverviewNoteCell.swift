//
//  OverviewNoteCell.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 07.11.2021.
//

import SwiftUI

struct OverviewNoteCell: View {
    
    let backgroundColor: Color
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12)
                .fill(self.backgroundColor)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Deadline")
                    .font(.system(size: 15, weight: .light, design: .rounded))
                    .foregroundColor(Color.gray)
                
                Label {
                    Text("Zbývají 3 dny")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 7))
                        .foregroundColor(.red)
                }
                
                
                Text("Dodělat semestrálku na OOP")
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .lineLimit(4)
            }
            .padding()
        }
        .frame(width: 150, height: 150)
        .padding(.trailing, 10)
    }
}

struct OverviewNoteCell_Previews: PreviewProvider {
    static var previews: some View {
        OverviewNoteCell(backgroundColor: Color.customLightRed)
    }
}

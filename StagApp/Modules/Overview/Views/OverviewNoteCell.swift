//
//  OverviewNoteCell.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 07.11.2021.
//

import SwiftUI

struct OverviewNoteCell: View {
    
    let note: Note
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.customLightRed)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(note.title ?? "")
                        .font(.system(size: 15, weight: .light, design: .rounded))
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                }
                
                    
                HStack {
                    
                
                if (note.date != nil) {
                    Label {
                        Text("Zbývá \(self.getDaysBetween(sinceDate: note.date!)) dnů")
//                        Text(DateFormatter.basic.string(from: note.date!))
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                    } icon: {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 7))
                            .foregroundColor(.red)
                    }
                }
                
                }
                
                
                Text(note.descriptionText ?? "")
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .lineLimit(4)
            }
            
            .padding(7)
            .padding(.top, 5)
            
        }
        .frame(width: 150, height: 150)
        .padding(.trailing, 10)
    }
    
    public func getDaysBetween(sinceDate: Date) -> String {
        let calendar = Calendar.current
        let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: Date()), to: calendar.startOfDay(for: sinceDate))
        
        
        return String(days.value(for: .day)!)
    }
}




//struct OverviewNoteCell_Previews: PreviewProvider {
//    static var previews: some View {
//
//        OverviewNoteCell(note: mockNote())
//    }
//
//    private static func mockNote() -> Note {
//        let note = Note()
//        note.title = "aa"
//        note.descriptionText = "test"
//
//        return note
//    }
//}

import SwiftUI

/// Component of ``OverviewScreen``. Presents single note
struct OverviewNoteCell: View {
    
    @ObservedObject var note: Note
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12)
                .fill(self.getBackgroundColor(sinceDate: note.date))
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(note.title ?? "")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                                            
                    Spacer()
                }
                
                    
                HStack {
                    
                
                if (note.date != nil) {
                    Label {
                        Text("overview.note-cell-reaming \(String(self.getDaysBetween(sinceDate: note.date!)))")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                    } icon: {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 7))
                            .foregroundColor(self.getDaysBetween(sinceDate: note.date!) > 3 ? .green : .red)
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
    
    private func getDaysBetween(sinceDate: Date) -> Int {
        let calendar = Calendar.current
        let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: Date()), to: calendar.startOfDay(for: sinceDate))
        
        
        return days.value(for: .day)!
    }
    
    private func getBackgroundColor(sinceDate: Date?) -> Color {
        
        if (sinceDate == nil) {
            return .customLightBlue
        }
        
        let days = self.getDaysBetween(sinceDate: sinceDate!)
        
        if (days > 0 && days > 3) {
            return .customLightGreen
        }
        
        return .customLightRed
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

import SwiftUI


/// Component of screen ``ThesesScreen``. Presents thesis cell
struct TheseCellView: View {
    
    let thesis: Thesis
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    
                    (Text(self.thesis.type.capitalized) + Text("theses.work"))
                        .font(.system(size: 15, weight: .light, design: .rounded))
                
                    Text(thesis.title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                
                    Label(StringHelper.concatStringsToOne(strings: self.thesis.student.getFullNameWithTitles(), self.thesis.student.username ?? ""), systemImage: "person")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                
                    Label {
                        Text(StringHelper.concatStringsToOne(strings: self.thesis.department, self.thesis.studentField))
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    } icon: {
                        Image("symbol-pin-2")
                            .resizable()
                            .frame(width: 17, height: 17)
                    }
                    
                    Label(self.thesis.submissionDate?.value ?? "-", systemImage: "clock.badge.exclamationmark")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    
                    if (self.thesis.supervisor != nil) {
                        Label {
                            (Text(LocalizedStringKey("theses.supervisor")) + Text(" ∙ \(self.thesis.supervisor!)"))
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        } icon: {
                            Image(systemName: "person")
                        }
                    }
                       
                    if (self.thesis.consultant != nil) {
                        Label {
                            (Text(LocalizedStringKey("theses.consultant")) + Text(" ∙ \(self.thesis.consultant!)"))
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        } icon: {
                            Image(systemName: "person")
                        }
                    }

                    if (self.thesis.opponent != nil) {
                        Label {
                            (Text(LocalizedStringKey("theses.opponent")) + Text(" ∙ \(self.thesis.opponent!)"))
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        } icon: {
                            Image(systemName: "person")
                        }
                    }

                    if (self.thesis.trainer != nil) {
                        Label {
                            (Text(LocalizedStringKey("theses.trainer")) + Text(" ∙ \(self.thesis.trainer!)"))
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        } icon: {
                            Image(systemName: "person")
                        }
                    }
                    
                }
                .padding()
                    
                Spacer()
            }
        }
        .shadow(color: Color.shadow, radius: 4)
        .padding([.leading, .trailing, .bottom])
        
    }
}

//struct TheseCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.defaultBackground.ignoresSafeArea()
//            TheseCellView()
//        }
//
//    }
//}

import SwiftUI

/// Component of ``StudentScreen``. Presents result cell
struct SubjectResultView: View {
    
    @Binding var subject: Subject
    
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(self.subject.name ?? "").bold().font(.system(size: 18, design: .rounded))

                Text((self.subject.department ?? "") + "/" + (self.subject.short ?? "")).font(.system(size: 18, design: .rounded))
                
                Text("student.credits \(subject.credits)").font(.system(size: 15, design: .rounded))
                
                (Text("student.before-exam").bold() + Text(StringHelper.concatStringsToOne(strings:
                                                        subject.creditBeforeExamTeacher ?? "",
                                                        subject.creditBeforeExamDate ?? "",
                                                        separatorOnFirstPosition: true
                                           )).font(.system(size: 15, design: .rounded)))
                
                (Text("student.exam").bold() + Text(StringHelper.concatStringsToOne(strings:
                                                        subject.examTeacher ?? "",
                                                        subject.examDate ?? "",
                                                        separatorOnFirstPosition: true
                                           )).font(.system(size: 15, design: .rounded)))
                
                (Text("student.evaluation").bold() + Text(StringHelper.concatStringsToOne(strings:
                                                        subject.examGrade ?? "?",
                                                        separatorOnFirstPosition: true
                                            )).font(.system(size: 15, design: .rounded)))
            }
            .padding()
            
        }
        .padding()
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.shadow, radius: 4)
        
    }
}

//struct SubjectResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubjectResultView()
//    }
//}

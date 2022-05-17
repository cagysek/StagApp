//
//  ExamTermView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 18.11.2021.
//

import SwiftUI

/// Component of ``ExamsScreen``. Presents single exam cell
struct ExamTermView: View {
        
     var exam: Exam
    
    var vm: ExamsViewModel
    
    @State var isEnrolled: Bool = false
    @State var currentStudentCount: Int = 0
    @State var showUnrollDialog: Bool = false
    @State var showEnrollDialog: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 8)
                .padding(.leading)
                .padding(.trailing)
                .foregroundColor(self.getBackgroundColor())
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text(self.exam.type)
                    .font(.system(size: 15, weight: .light, design: .rounded))
                Text("\(self.exam.date?.value ?? "") ∙ \(self.exam.getTimeInterval())")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Label(self.exam.teacher?.getFormattedName() ?? "-", systemImage: "person")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                Label {
                    Text("\(self.exam.building)-\(self.exam.room)")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                } icon: {
                    Image("symbol-pin-2")
                        .resizable()
                        .frame(width: 17, height: 17)
                }
                
                Label("exam.enroll-to \(self.exam.deadlineLogInDate?.value ?? "")", systemImage: "clock.badge.checkmark")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                
                Label("exam.unenroll-to \(self.exam.deadlineLogOutDate?.value ?? "")", systemImage: "clock.badge.exclamationmark")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                
                

                Label("exam.capacity \(self.currentStudentCount) \(self.exam.getLimit())", systemImage: "person.2.circle")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                
                HStack {
                    Spacer()
                    
                    if (self.exam.isEnrollable) {
                        if (self.isEnrolled) {
                            Button("exam.unenroll", action: {
                                self.showUnrollDialog = true
                            })
                            .confirmationDialog("exam.unenroll-text", isPresented: self.$showUnrollDialog, titleVisibility: .visible, actions: {
                                Button("common.yes", role: .destructive) {
                                    Task.init {
                                        let result = await vm.logOutFromExam(examId: self.exam.id)
                                        
                                        if (result) {
                                            self.isEnrolled = false
                                            self.currentStudentCount -= 1
                                        }
                                    }
                                }
                            })
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                        } else {
                            Button("exam.enroll", action: {
                                self.showEnrollDialog = true
                            })
                            .confirmationDialog("exam.enroll-text", isPresented: self.$showEnrollDialog, titleVisibility: .visible, actions: {
                                Button("common.yes", role: .destructive) {
                                    Task.init {
                                        let result = await vm.logInToExam(examId: self.exam.id)
                                        
                                        if (result) {
                                            self.isEnrolled = true
                                            self.currentStudentCount += 1
                                        }
                                    }
                                }
                            })
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                        }
                    } else {
                        if (self.exam.enrolled) {
                            Text(self.exam.limitEnrollableMsg ?? "exam.unenroll-error")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        } else {
                            Text(self.exam.limitEnrollableMsg ?? "exam.unenroll-error")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                        }
                    }
                    
                    
                }
                .padding(.top, 5)
                
                if (self.exam.note != nil) {
                    Divider()
                    Text(self.exam.note ?? "").font(.system(size: 14, weight: .light, design: .rounded))
                        .fixedSize(horizontal: false, vertical: true)
                }
                    
                
            }
            .padding()
            .padding(.leading)
            .padding(.trailing)
            .onAppear {
                self.isEnrolled = exam.enrolled
                self.currentStudentCount = exam.currentStudentsCount.isNumeric ? Int(exam.currentStudentsCount)! : 0
            }
        }
        .padding(.bottom, 10)
    }
    
    
    private func getBackgroundColor() -> Color {
        if (!self.exam.isEnrollable) {
            return .customLightRed
        } else if (self.isEnrolled) {
            return .customYellow
        }
        
        return .customLightBlue
    }
}

//struct ExamTermView_Previews: PreviewProvider {
//    static var previews: some View {
//
//            let examJson = "{\"termIdno\":1118482,\"ucitIdno\":59289,\"ucitel\":{\"ucitIdno\":59289,\"jmeno\":\"Lukáš\",\"prijmeni\":\"Hilas\",\"titulPred\":\"Ing.\",\"titulZa\":\"Ph.D.\",\"platnost\":\"A\",\"zamestnanec\":\"A\",\"katedra\":\"KIV\",\"pracovisteDalsi\":\"PC\",\"email\":\"Martina63712902@index5.cz\",\"telefon\":\"578161289\",\"telefon2\":null,\"url\":null},\"predmet\":\"VSS\",\"katedra\":\"KIV\",\"rok\":\"2021\",\"semestr\":\"ZS\",\"datum\":{\"value\":\"24.2.2022\"},\"obsazeni\":\"1\",\"limit\":\"10\",\"casOd\":\"10:00:00\",\"casDo\":\"14:00:00\",\"budova\":\"UC\",\"mistnost\":\"355\",\"kontakt\":null,\"poznamka\":\"Sraz bude před místností UN 306.\",\"opravny\":\"N\",\"deadlineDatumOdhlaseni\":{\"value\":\"23.2.2022 10:00\"},\"deadlineDatumPrihlaseni\":{\"value\":\"24.2.2022 9:00\"},\"zacatekPrihlasovani\":null,\"platnost\":\"A\",\"typTerminu\":\"Zkouška\",\"grteIdno\":null,\"osCislo\":\"A20N6844P\",\"zapsan\":true,\"lzeZapsatOdepsat\":true,\"kodDuvoduProcNelzeZapsatOdepsat\":\"OK\",\"textDuvoduProcNelzeZapsatOdepsat\":null,\"popisDuvoduProcNelzeZapsatOdepsat\":null}"
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: examJson)
//        let exam = try? JSONDecoder().decode(Exam.self, from: jsonData!)
//
//            ExamTermView(exam: exam!)
//
//
//    }
//}

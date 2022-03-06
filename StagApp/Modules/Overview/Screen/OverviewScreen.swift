//
//  OverviewScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import SwiftUI

struct OverviewScreen: View {
    
    @Environment(\.calendar) var calendar
    
    @Binding var selectedTabIndex: Int
    @State private var showNotesAddSheet = false
    
    @StateObject var vm = OverviewViewModel(stagService: StagService(), noteRepository: NoteRepository(context: CoreDataManager.getContext()))
    
    @Binding var selectedDate: Date?
    
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            
            
                VStack {
                    HStack(alignment:.bottom) {
                        Text("Přehled")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .padding(.bottom, -3)
                        
                        Spacer()
                        
                        Text(self.getCurrentDate())
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        
                        Text(self.getWeekStatus())
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                    }
                    .padding()
                    
                    
                    ZStack(alignment: .top) {
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .padding([.leading, .trailing])
                            
                        VStack {
                            HStack(alignment: .bottom) {
                                Text("Dnešní rozvrh (\(self.vm.scheduleActionsCount))")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                
                                Spacer()
                                
                                Button("Zobrazit vše") {
                                    self.selectedTabIndex = 0
                                    self.selectedDate = Date()
                                }
                                .buttonStyle(BasicButtonStyle())
                            }
                            .padding(.trailing, 30)
                            .padding(.leading, 30)
                            .padding(.bottom, 10)
                        
                            if (self.vm.scheduleActions.isEmpty) {
                                if (self.vm.scheduleActionsCount == 0) {
                                    Spacer()
                                    Text("Dnes nemáš žádnou výuku! ☀️")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                    Spacer()
                                }
                                else {
                                    Spacer()
                                    Text("Dneska už máš padla! 😬")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                    Spacer()
                                }
                            } else {
                                ForEach(self.vm.scheduleActions) { scheduleAction in
                                    OverviewSubjectCell(scheduleAction: scheduleAction)
                                }
                            }
                        }
                        .padding(.top, 15)
                        
                        
                    }
                    .frame(height: self.vm.scheduleActions.isEmpty ? 150 : 292)
                    .shadow(color: Color.shadow, radius: 4)
                    
                    
                    
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .padding([.leading, .trailing])
                            
                        VStack {
                            HStack(alignment: .bottom) {
                                Text("Připomínky (\(self.vm.notes.count))")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                
                                Spacer()
                                
                                Button("Zobrazit vše") {
                                    
                                }
                                .buttonStyle(BasicButtonStyle())
                            }
                            .padding(.trailing, 30)
                            .padding(.leading, 30)
                            .padding(.bottom, 10)
                        
                            if (self.vm.notes.isEmpty) {
                                Spacer()
                                Text("Žádné připomínky 📝")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                Spacer()
                            } else {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(self.vm.notes) { note in
                                            OverviewNoteCell(note: note)
                                        }
                                    }
                                }
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                                .padding(.bottom, 15)
                            }
                            
                            
                            
                            HStack {
                                Spacer()
                                Button("+ Přidat") {
                                    self.showNotesAddSheet.toggle()
                                }
                                .buttonStyle(BasicButtonStyle())
                            }
                            .padding(.trailing, 30)
                            .padding(.bottom, 15)
                            
                        
                        }
                        .padding(.top, 15)
                        
                        
                    }
                    .frame(height: 260)
                    .shadow(color: Color.shadow, radius: 4)
                    .padding(.top)
                    
                    
                    Spacer()
                
            }
        }
        .foregroundColor(.defaultFontColor)
        .sheet(isPresented: $showNotesAddSheet, onDismiss: {
            self.vm.updateNotes()
        }) {
            AddNoteView()
        }
        .onAppear {
            self.vm.updateSchedule()
        }
        
    }
    
    fileprivate func getCurrentDate() -> String {
        return DateFormatter.basic.string(from: Date())
    }
    
    fileprivate func getWeekStatus() -> String {
        let weekOfYear = self.calendar.component(.weekOfYear, from: Date())
        
        if (weekOfYear % 2 == 0)
        {
            return "sudý týden"
        }
        
        return "lichý týden"
    }
}


struct OverviewScreen_Previews: PreviewProvider {
    
    @State static var date: Date? = Date()
    
    static var previews: some View {
        OverviewScreen(selectedTabIndex: .constant(0), selectedDate: $date)
    }
}

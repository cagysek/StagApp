//
//  ScheduleScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct ScheduleScreen: View {
    
    @ObservedObject var vm: ScheduleViewModel
    
    @Binding var selectedDate: Date?
    
    @State private var showSheetActionDetail = false
    
    @State private var lastSelectedSchedule: ScheduleAction? = nil
    
    init(selectedDate: Binding<Date?>) {
        self._vm = ObservedObject(wrappedValue: ScheduleViewModel(stagService: StagService(), studentRepository: StudentRepository(context: CoreDataManager.getContext())))
        self._selectedDate = selectedDate
    }
        
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()

            VStack {
                HStack(alignment:.bottom) {
                    Text("Rozvrh")
                        .font(.system(size: 32, weight: .bold, design: .rounded))

                    Spacer()
                }
                .padding()

                VStack {
                    CalendarView(vm: self.vm, selectedDate: self.$selectedDate)

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                        switch self.vm.state {
                            case .idle:
                                    if (!self.vm.scheduleActions.isEmpty) {
                                        ForEach(vm.scheduleActions, id: \.id) { scheduleAction in
                                            ScheduleActionView(scheduleAction: scheduleAction)
                                                .onTapGesture {
                                                    self.lastSelectedSchedule = scheduleAction
                                                    self.showSheetActionDetail.toggle()
                                                    
                                                }
                                        }
                                    }
                                    else {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill()
                                                .foregroundColor(Color.white)
                                                .frame(height: 90)
                                                .shadow(color: Color.shadow, radius: 8)
                                            
                                            Text("schedule.no-class-today").font(.system(size: 16, weight: .regular, design: .rounded))
                                        }
                                        .padding()
                                    }
                            case .fetchingData:
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill()
                                            .foregroundColor(Color.white)
                                            .frame(height: 90)
                                            .shadow(color: Color.shadow, radius: 8)
                                        
                                        LoadingView(text: "common.loading")
                                    }
                                    .padding()
                                    
                            case .error(msg: let msg):
                                Text(msg)
                        }
                            
                            
                            
                            
                        }
                        .padding(.bottom, 30)

                    }
                    .padding(.leading, -15)
                    .padding(.trailing, -15)
                    .padding(.bottom, -15)

                }
                .padding(.leading)
                .padding(.trailing)
                .sheet(isPresented: $showSheetActionDetail) {
                    SubjectDetailScreen(scheduleAction: self.$lastSelectedSchedule)
                }
            }
        }
        .foregroundColor(.defaultFontColor)
        
    }
}

//struct ScheduleScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleScreen()
//    }
//}


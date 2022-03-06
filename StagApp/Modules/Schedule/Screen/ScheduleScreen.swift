//
//  ScheduleScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct ScheduleScreen: View {
    
    @StateObject var vm = ScheduleViewModel(stagService: StagService())
    
    @Binding var selectedDate: Date?
        
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
                            if (!self.vm.scheduleActions.isEmpty) {
                                ForEach(vm.scheduleActions, id: \.id) { scheduleAction in
                                    ScheduleActionView(scheduleAction: scheduleAction)
                                }
                            }
                            else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill()
                                        .foregroundColor(Color.white)
                                        .frame(height: 90)
                                        .shadow(color: Color.shadow, radius: 8)
                                    
                                    Text("Dnes nemáš žádnou výuku! ☀️").font(.system(size: 16, weight: .regular, design: .rounded))
                                }
                                .padding()
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


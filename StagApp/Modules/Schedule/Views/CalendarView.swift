//
//  CalendarView.swift
//  StagApp
//


import Foundation
import SwiftUI

struct CalendarView: View {
    
    @Environment(\.calendar) var calendar
    
    @State var selectedIndex: Int = 0
    
    @State var monthTitle: String = ""
    
    @State var selectedDate: Date = Date()
    
    var vm: ScheduleViewModel
    
    private var myInterval: [Date] {
        let pastdate = Date.now.addingTimeInterval(86400 * -60)
        let futureDate = Date.now.addingTimeInterval(86400 * 60)
        
        
        return calendar.generateDates(
            inside: DateInterval(start: pastdate, end: futureDate),
            matching: DateComponents(hour: 1, minute: 0, second: 0)
        )
    }

    var body: some View {
        ScrollViewReader { proxy in
            HStack {
                Text(self.monthTitle)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
                Spacer()
                
                Button("Dnes") {
                    withAnimation {
                        let date = Date()
                        
                        let index = getDateIndex(date)
                        
                        Task.init {
                            await self.vm.loadScheduleActions(for: date)
                        }
                        
                        proxy.scrollTo(index, anchor: .center)
                        
                        self.selectedIndex = index
                        self.selectedDate = date
                    }
                }
                .buttonStyle(WhiteCapsuleButtonStyle())
//
//                    Button {
//
//                    } label: {
//                        Image(systemName: "slider.horizontal.3")
//                    }
//                    .buttonStyle(WhiteCapsuleButtonStyle())
            }
            .padding(.bottom)
                
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(myInterval, id: \.self) { date in
                        Button {
                            self.selectedIndex = getDateIndex(date)
                            Task.init {
                                await self.vm.loadScheduleActions(for: date)
                            }
                            
                        } label: {
                            if (self.selectedIndex == getDateIndex(date))
                            {
                                VStack(alignment: .center, spacing: 5) {
                                    Text(String(DateFormatter.day.string(from: date)))
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                    Text(String(self.calendar.component(.day, from: date)))
                                        .font(.system(size: 14, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                                .background(Color.customBlue)
                                
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            else
                            {
                                VStack(alignment: .center, spacing: 5) {
                                    Text(String(DateFormatter.day.string(from: date)))
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.gray)
                                    Text(String(self.calendar.component(.day, from: date)))
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        .foregroundColor(.defaultFontColor)
                                }
                                .padding(15)
                            }
                        }
                        .id(getDateIndex(date))
                        .onAppear {
                            self.monthTitle = DateFormatter.monthAndYear.string(from: date).firstCapitalized
                        }
                    }
                }
                
            }
            .onAppear(perform: {
                
                Task.init {
                    await self.vm.loadScheduleActions(for: self.selectedDate)
                }
                
                
                if (selectedIndex == 0) {
                    self.selectedIndex = getDateIndex(self.selectedDate)
                }
                
                proxy.scrollTo(self.selectedIndex, anchor: .center)
            })
            .frame(height: 60)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .shadow, radius: 8)
            
        }
    }
}

// MARK: Index function
fileprivate func getDateIndex(_ date: Date) -> Int {
    return Int(DateFormatter.dateIndex.string(from: date))!
}





// MARK: Function for enumerate dates for iteration
fileprivate extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
    
        return dates
    }
}

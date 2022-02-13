//
//  CalendarView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.02.2022.
//

import Foundation
import SwiftUI

struct CalendarRootView: View {
    
    @Environment(\.calendar) var calendar
    
    @State var selectedIndex: Int = 0
    
    
    private var year: DateInterval {
        calendar.dateInterval(of: .month, for: Date())!
    }

        var body: some View {
            ScrollViewReader { proxy in
                
                HStack {
                    Text("Listopad 2021")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    Button("Dnes") {
                        withAnimation {
                            let index = getDateIndex(Date())
                            proxy.scrollTo(index, anchor: .center)
                            self.selectedIndex = index

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
                    
                
                
                CalendarView(interval: year) { date in
                    Button {
                        self.selectedIndex = getDateIndex(date)
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
                    
                }
                .onAppear(perform: {
                    if (selectedIndex == 0) {
                        self.selectedIndex = getDateIndex(Date())
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

fileprivate func getDateIndex(_ date: Date) -> Int {
    return Int(DateFormatter.dateIndex.string(from: date))!
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let content: (Date) -> DateView

    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(months, id: \.self) { month in
                    MonthView(month: month, content: self.content)
                }
            }
        }
    }
}

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    static var day: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        
        return formatter
    }
    
    static var dateIndex: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYMMdd"
        
        return formatter
    }
}


fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
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

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let content: (Date) -> DateView

    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }

    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                
//                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                        
//                    } else {
//                        self.content(date).hidden()
//                    }
                
            }
        }
    }
}

struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let showHeader: Bool
    let content: (Date) -> DateView

    init(
        month: Date,
        showHeader: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.content = content
        self.showHeader = showHeader
    }

    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }

//    private var header: some View {
//        let component = calendar.component(.month, from: month)
//        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
//
//        return Text(formatter.string(from: month))
//            .font(.title)
//            .padding()
//    }

    var body: some View {
        VStack {
//            if showHeader {
//                header
//            }

            HStack {
                ForEach(weeks, id: \.self) { week in
                    WeekView(week: week, content: self.content)
                }
            }
            
        }
    }
}

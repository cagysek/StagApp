//
//  Date+resetTime.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 30.03.2022.
//

import Foundation


extension Date {

    
    /// Support function for reset time on date
    /// - Returns: date with reset time
    func resetTime() -> Date
    {
        let calendar = Calendar.current

        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)

        components.minute = 0
        components.second = 0
        components.hour = 0

        return calendar.date(from: components)!
    }

}

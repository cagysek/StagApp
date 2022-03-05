//
//  DateFormatter+custom.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 16.02.2022.
//

import Foundation

// MARK: Date formatters
extension DateFormatter {
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
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
    
    static var basic: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter
    }
    
    static var time: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter
    }
}

import Foundation
import UIKit
import SwiftUI

public struct ScheduleAction: Decodable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case id = "roakIdno"
        case title = "nazev"
        case department = "katedra"
        case titleShort = "predmet"
        case teacher = "ucitel"
        case year = "rok"
        case building = "budova"
        case room = "mistnost"
        case label = "typAkce"
        case labelShort = "typAkceZkr"
        case semester = "semestr"
        case day = "den"
        case dayShort = "denZkr"
        case timeFrom = "hodinaSkutOd"
        case timeTo = "hodinaSkutDo"
        case weekFrom = "tydenOd"
        case weekTo = "tydenDo"
        case howOften = "tyden"
        case howOftenShort = "tydenZkr"
        case type = "druhAkce"
    }
    
    public let id: Int
    let title: String
    let department: String
    let titleShort: String
    let teacher: Teacher?
    let year: String
    let building: String?
    let room: String?
    let label: String
    let labelShort: String
    let semester: String
    let day: String?
    let dayShort: String?
    let weekFrom: Int
    let weekTo: Int
    let type: String
    let howOften: String
    let howOftenShort: String
    let timeFrom: ValueProperty?
    let timeTo: ValueProperty?
    
    
    public func getTimeOfAction() -> String {
        if (self.timeFrom == nil || self.timeTo == nil) {
            return ""
        }
        
        if (weekFrom == 0 || weekTo == 0) {
            return ""
        }
        
        
        return "\(self.timeFrom!.value) - \(self.timeTo!.value)"
    }
    
    public func getDuration() -> String {
        if (self.timeFrom == nil || self.timeTo == nil) {
            return ""
        }
        
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "HH:mm"

        guard let time1 = timeformatter.date(from: self.timeFrom!.value),
              let time2 = timeformatter.date(from: self.timeTo!.value) else { return "" }


        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        
        if (hour == 0 && minute == 0)
        {
            return ""
        }
        
        if (minute == 0)
        {
            return "\(Int(hour)) h"
        }
        
        return "\(Int(hour)) h \(Int(minute)) min"
    }
    
    public func getBackgroundColor() -> Color {
        if (self.labelShort == "Se") {
            
            return Color.customLightGreen2
            
        } else if (self.labelShort == "Cv") {
            
            return Color.customLightGreen
            
        } else if (self.labelShort == "Zkouška") {
                    
            return Color.customYellow
                    
        } else {
            
            return Color.customDarkGray
        }
    }
}


public struct ScheduleActionsRoot: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case scheduleActions = "rozvrhovaAkce"
    }
    
    let scheduleActions: [ScheduleAction]
}

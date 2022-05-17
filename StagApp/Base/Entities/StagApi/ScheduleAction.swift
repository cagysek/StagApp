import Foundation
import UIKit
import SwiftUI


/// Entity for API response of `fetchStudentScheduleActions()` and `fetchTeacherScheduleActions()`
public struct ScheduleAction: Decodable, Identifiable {
    
    /// API response fiealds mapping
    enum CodingKeys: String, CodingKey {
        case scheduleId = "roakIdno"
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
    
    
    /// Unique identifier
    public let id = UUID()
    
    /// Shedule action's ID
    let scheduleId: Int?
    
    /// Shedule action's title
    let title: String
    
    /// Shedule action's department
    let department: String
    
    /// Shedule action's title shortcut
    let titleShort: String
    
    /// Shedule action's teacher
    let teacher: TeacherApi?
    
    /// Shedule action's year
    let year: String
    
    /// Shedule action's building
    let building: String?
    
    /// Shedule action's room
    let room: String?
    
    /// Shedule action's label (Lectute, exam, exercise)
    let label: String
    
    /// Shedule action's label short (Le, exam, se)
    let labelShort: String
    
    /// Shedule action's semester
    let semester: String
    
    /// Shedule action's title of day
    let day: String?
    
    /// Shedule action's title of day shortcut
    let dayShort: String?
    
    /// Shedule action's starting week
    let weekFrom: Int
    
    /// Shedule action's ending week
    let weekTo: Int
    
    /// Shedule action's type
    let type: String
    
    /// Shedule action's indication how eften is repeated (every week, odd, ...)
    let howOften: String
    
    /// Shedule action's shortcut of indication how often is repeated
    let howOftenShort: String
    
    /// Shedule action's start time
    let timeFrom: ValueProperty?
    
    /// Shedule action's end time
    let timeTo: ValueProperty?
    
    
    /// Return time interval for shecule action
    /// - Returns: Formatted time interval
    public func getTimeOfAction() -> String {
        if (self.timeFrom == nil || self.timeTo == nil) {
            return ""
        }
        
        if (weekFrom == 0 || weekTo == 0) {
            return ""
        }
        
        
        return "\(self.timeFrom!.value) - \(self.timeTo!.value)"
    }
    
    /// Returns duration of schedule action
    /// - Returns: duration of schedule action
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
    
    /// Depends on schedule action's type returns color
    /// - Returns: schedule action's background color
    public func getBackgroundColor() -> Color {
        if (self.labelShort == "Se") {
            
            return Color.customLightGreen2
            
        } else if (self.labelShort == "Cv") {
            
            return Color.customLightGreen
            
        } else if (self.labelShort == "Zkouška" || (self.labelShort == "Záp. před zk.")) {
                    
            return Color.customYellow
                    
        } else {
            
            return Color.customDarkGray
        }
    }
    
    
    /// Returns translation for type shortcut
    /// - Returns: translation key for schedule type shortcut
    public func getLabelShortTranslation() -> String {
        let language = LanguageService.shared.language
        
        switch self.label {
            case "Přednáška":
                return "scheduleDetail.lecture-short".localized(language)
            case "Seminář":
                return "scheduleDetail.seminar-short".localized(language)
            case "Zkouška":
                return "scheduleDetail.exam-short".localized(language)
            case "Záp. před zk.":
                return "scheduleDetail.credit-before-exam-short".localized(language)
            default:
                return self.label
        }
    }
    
    /// Returns translation for type shortcut
    /// - Returns: translation key for schedule type shortcut
    public func getLabelTranslation() -> String {
        let language = LanguageService.shared.language
        
        switch self.label {
            case "Přednáška":
                return "scheduleDetail.lecture".localized(language)
            case "Seminář":
                return "scheduleDetail.seminar".localized(language)
            case "Zkouška":
                return "scheduleDetail.exam".localized(language)
            case "Cvičení":
                return "scheduleDetail.exercise".localized(language)
            case "Záp. před zk.":
                return "scheduleDetail.credit-before-exam".localized(language)
            default:
                return self.label
        }
    }
}

/// Entity for API response root of `fetchStudentScheduleActions()` and `fetchTeacherScheduleActions()`
public struct ScheduleActionsRoot: Decodable {
    
    /// API response mapping
    enum CodingKeys: String, CodingKey {
        case scheduleActions = "rozvrhovaAkce"
    }
    
    /// Response root
    let scheduleActions: [ScheduleAction]
}

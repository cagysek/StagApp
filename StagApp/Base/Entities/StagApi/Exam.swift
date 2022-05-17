import Foundation
import SwiftUI


/// Entity for API response `fetchExamDates()`
struct Exam: Decodable {
    
    /// API response field mapping
    enum CodingKeys: String, CodingKey {
        case id = "termIdno"
        case teacher = "ucitel"
        case subject = "predmet"
        case department = "katedra"
        case year = "rok"
        case semester = "semestr"
        case date = "datum"
        case limit = "limit"
        case currentStudentsCount = "obsazeni"
        case timeFrom = "casOd"
        case timeTo = "casDo"
        case building = "budova"
        case room = "mistnost"
        case correctionTerm = "opravny"
        case deadlineLogOutDate = "deadlineDatimOdhlaseni"
        case deadlineLogInDate = "deadlineDatumPrihlaseni"
        case type = "typTerminu"
        case enrolled = "zapsan"
        case isEnrollable = "lzeZapsatOdepsat"
        case limitEnrollableCode = "kodDuvoduProcNelzeZapsatOdepsat"
        case limitEnrollableMsg = "textDuvoduProcNelzeZapsatOdepsat"
        case limitEnrollableDescription = "popisDuvoduProcNelzeZapsatOdepsat"
        case note = "poznamka"
    }
    
    /// Exam's id
    let id: Int
    
    /// Exam's teacher
    let teacher: TeacherApi?
    
    /// Exam's suject
    let subject: String
    
    /// Exam's department
    let department: String
    
    /// Exam's year
    let year: String
    
    /// Exam's semester
    let semester: String
    
    /// Exam's date
    let date: ValueProperty?
    
    /// Exam's students limit
    let limit: String
    
    /// Exam's start
    let timeFrom: String
    
    /// Exam's end
    let timeTo: String
    
    /// Enrolled number of students
    let currentStudentsCount: String
    
    /// Exam's building
    let building: String
    
    /// Exam's room
    let room: String
    
    /// Is correction term
    let correctionTerm: String
    
    /// Exam's deadline for log out
    let deadlineLogOutDate: ValueProperty?
    
    /// Exam's deadline for log in
    let deadlineLogInDate: ValueProperty?
    
    /// Exam's type
    let type: String
    
    /// Is current student enrolled
    let enrolled: Bool
    
    /// Can be exam enrolled
    let isEnrollable: Bool
    
    /// Why can't be exam enrolled code
    let limitEnrollableCode: String?
    
    /// Why can't be exam enrolled message
    let limitEnrollableMsg: String?
    
    /// Why can't be exam enrolled detailed info
    let limitEnrollableDescription: String?
    
    /// Exam's note from teacher
    let note: String?
    
    public func getTimeInterval() -> String {
        
        let timeFrom = self.timeFrom.prefix(5)
        let timeTo = self.timeTo.prefix(5)
        
        return "\(timeFrom) - \(timeTo)"
    }
    
    public func getLimit() -> String {
        if (self.limit == "null") {
            return "-"
        }
        
        return self.limit
    }
        
}


/// Entity for API root response `fetchExamDates()`
struct ExamRoot: Decodable {
    
    /// API response field mapping
    enum CodingKeys: String, CodingKey {
        case exams = "termin"
    }
    
    
    /// Root field
    let exams: [Exam]
}

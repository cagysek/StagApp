//
//  SubjectResult.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 09.01.2022.
//

import Foundation


/// Entity for map fetchSubjectResults from ``StagService``
struct SubjectResult: Codable, Hashable {
    
    
    /// API response mapping
    enum CodingKeys: String, CodingKey {
        case department = "katedra"
        case subjectShort = "zkratka"
        case year = "rok"
        case semester = "semestr"
        case examDate = "zk_datum"
        case examGrade = "zk_hodnoceni"
        case examTeacher = "zk_ucit_jmeno"
        case examAttempt = "zk_pokus"
        case examPoints = "zk_body"
        case creditBeforeExamGrade = "zppzk_hodnoceni"
        case creditBeforeExamDate = "zppzk_datum"
        case creditBeforeExamTeacher = "zppzk_ucit_jmeno"
        case creditBeforeExamAttempt = "zppzk_pokus"
    }
    
    
    /// Subject result's department
    let department: String
    
    /// Subject result's title shortcut
    let subjectShort: String
    
    /// Subject result's year
    let year: String
    
    /// Subject result's semester
    let semester: String
    
    /// Subject result's exam date
    let examDate: String?
    
    /// Subject result's exam grade
    let examGrade: String?
    
    /// Subject result's exam teacher
    let examTeacher: String?
    
    /// Subject result's exam attempt
    let examAttempt: String?
    
    /// Subject result's exam points
    let examPoints: String?
    
    /// Subject result's credit before exam date
    let creditBeforeExamDate: String?
    
    /// Subject result's xreadit before exam grade
    let creditBeforeExamGrade: String?
    
    /// Subject result's credit before exam teacher
    let creditBeforeExamTeacher: String?
    
    /// Subject result's credit before exam attempt
    let creditBeforeExamAttempt: String?
    
    
    /// Returns combination of subject's department and subject's title shortcut
    /// - Returns: combination of subject's department and subject's title shortcut
    public func getSubjctShort() -> String {
        return "\(self.department)/\(self.subjectShort)"
    }
    
}

/// Entity for map root fetchSubjectResults from ``StagService``
struct SubjectResultDisctionary: Codable {
    
    /// API fields mapping
    enum CodingKeys: String, CodingKey {
        case subjectResult = "student_na_predmetu"
    }
    
    /// API response root field
    let subjectResult: [SubjectResult]
}


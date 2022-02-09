//
//  SubjectResult.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 09.01.2022.
//

import Foundation


struct SubjectResult: Codable, Hashable {
    
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
    
    
    let department: String
    let subjectShort: String
    let year: String
    let semester: String
    let examDate: String?
    let examGrade: String?
    let examTeacher: String?
    let examAttempt: String?
    let examPoints: String?
    let creditBeforeExamDate: String?
    let creditBeforeExamGrade: String?
    let creditBeforeExamTeacher: String?
    let creditBeforeExamAttempt: String?
    
    public func getSubjctShort() -> String {
        return "\(self.department)/\(self.subjectShort)"
    }
    
}

struct SubjectResultDisctionary: Codable {
    
    enum CodingKeys: String, CodingKey {
        case subjectResult = "student_na_predmetu"
    }
    

    let subjectResult: [SubjectResult]
}


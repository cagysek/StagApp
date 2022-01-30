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
        case examTeacherName = "zk_ucit_jmeno"
        case creditBeforeExamDate = "zppzk_datum"
        case creditBeforeExamGrade = "zppzk_hodnoceni"
        case creditBeforeExamTeacherName = "zppzk_ucit_jmeno"
        
    }
    
    
    let department: String
    let subjectShort: String
    let year: String
    let semester: String
    let examDate: String?
    let examGrade: String?
    let examTeacherName: String?
    let creditBeforeExamDate: String?
    let creditBeforeExamGrade: String?
    let creditBeforeExamTeacherName: String?
    
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


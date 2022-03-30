//
//  SubjectStudent.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 06.03.2022.
//

import Foundation


struct SubjectStudent: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "osCislo"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case faculty = "fakultaSp"
        case fieldOfStudy = "nazevSp"
        case studyYear = "rocnik"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
    }
    
    let id: String
    let firstname: String
    let lastname: String
    let faculty: String
    let fieldOfStudy: String
    let studyYear: String
    let titleBefore: String?
    let titleAfter: String?
    
    public func getFormattedName() -> String {
        return ("\(self.firstname) \(self.lastname)").addTitles(titleBefore: self.titleBefore, titleAfter: self.titleAfter)
    }
    
}


struct SubjectStudentRoot: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case subjectStudents = "studentPredmetu"
    }
    
    let subjectStudents: [SubjectStudent]
}

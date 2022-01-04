//
//  StudentInfo.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 15.12.2021.
//

import Foundation

struct StudentInfo: Codable {
    
    enum CodingKeys: String, CodingKey {
        case studentId = "osCislo"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
        case username = "userName"
        case studyProgram = "nazevSp"
        case faculty = "fakultaSp"
        case studyYear = "rocnik"
        case email = "email"
    }
    
    
    let studentId: String
    let firstname: String
    let lastname: String
    let titleBefore: String?
    let titleAfter: String?
    let username: String
    let studyProgram: String
    let faculty: String
    let studyYear: String
    let email: String
    
}

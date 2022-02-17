//
//  Exam.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.02.2022.
//

import Foundation


struct Exam: Decodable {
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
        case textDuvoduProcNelzeZapsatOdepsat = "textDuvoduProcNelzeZapsatOdepsat"
        case limitEnrollableDescription = "popisDuvoduProcNelzeZapsatOdepsat"
    }
    
    let id: Int
    let teacher: Teacher
    let subject: String
    let department: String
    let year: String
    let semester: String
    let date: ValueProperty?
    let limit: String
    let timeFrom: String
    let timeTo: String
    let currentStudentsCount: String
    let building: String
    let room: String
    let correctionTerm: String
    let deadlineLogOutDate: ValueProperty?
    let deadlineLogInDate: ValueProperty?
    let type: String
    let enrolled: Bool
    let isEnrollable: Bool
    let limitEnrollableCode: String?
    let textDuvoduProcNelzeZapsatOdepsat: String?
    let limitEnrollableDescription: String?
    
}


struct ExamRoot: Decodable {
    enum CodingKeys: String, CodingKey {
        case exams = "termin"
    }
    
    let exams: [Exam]
}

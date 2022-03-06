//
//  SubjectDetail.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 06.03.2022.
//

import Foundation

struct SubjectDetail: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case department = "katedra"
        case short = "zkratka"
        case title = "nazev"
        case credits = "kreditu"
        case garants = "garanti"
        case speakers = "prednasejici"
        case practitioners = "cvicici"
        case seminarTeachers = "seminarici"
        case requiredSubjects = "podminujiciPredmety"
        case literature = "literatura"
        case lectureCount = "jednotekPrednasek"
        case practiseCount = "jednotekCviceni"
        case seminarCount = "jednotekSeminare"
        case goal = "anotace"
        case examType = "typZkousky"
        case creaditBeforeExam = "maZapocetPredZk"
        case examForm = "formaZkousky"
        case requirements = "pozadavky"
        case content = "prehledLatky"
        case prerequisites = "predpoklady"
        case subjectUrl = "predmetUrl"
    }
    
    
    
    let department: String
    let short: String
    let title: String
    let credits: Int
    let garants: String
    let speakers: String
    let practitioners: String
    let seminarTeachers: String
    let requiredSubjects: String
    let literature: String
    let lectureCount: Int
    let practiseCount: Int
    let seminarCount: Int
    let goal: String
    let examType: String
    let creaditBeforeExam: String
    let examForm: String
    let requirements: String
    let content: String
    let prerequisites: String
    let subjectUrl: String?
}

//
//  SubjectApi.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 09.02.2022.
//

import Foundation


struct SubjectApi: Codable {
    
    enum CodingKeys: String, CodingKey {
        case department = "katedra"
        case short = "zkratka"
        case year = "rok"
        case credits = "kredity"
        case name = "nazev"
        case type = "statut"
        case acknowledged = "uznano"
    }
    
    let department: String?
    let short: String
    let year: String
    let credits: Int
    let name: String
    let type: String
    let acknowledged: String
}

struct RootSubject: Codable {
    
    enum CodingKeys: String, CodingKey {
        case subjectResult = "predmetStudenta"
    }
    
    let subjectResult: [SubjectApi]
}

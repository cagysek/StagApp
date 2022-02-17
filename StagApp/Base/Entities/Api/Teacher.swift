//
//  Teacher.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.02.2022.
//

import Foundation

public struct Teacher: Decodable {
 
    enum CodingKeys: String, CodingKey {
        case id = "ucitIdno"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
    }
    
    let id: Int
    let firstname: String
    let lastname: String
    let titleBefore: String?
    let titleAfter: String?
}

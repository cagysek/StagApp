//
//  LoginResult.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.03.2022.
//

import Foundation

struct LoginResult: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case role = "role"
        case studentId = "osCislo"
        case teacherId = "ucitIdno"
        case username = "userName"
        case cookie = "cookie"
    }
    
    
    let role: String
    let studentId: String?
    let teacherId: String?
    let username: String
    var cookie: String?
    
}

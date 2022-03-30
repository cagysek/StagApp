//
//  StagInfo.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 30.03.2022.
//

import Foundation

struct StagInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case firstnam = "jmeno"
        case lastname = "prijmeni"
        case email = "email"
        case stagUserInfo = "stagUserInfo"
    }
    
    
    let firstnam: String
    let lastname: String
    let email: String
    let stagUserInfo: [StagUserInfo]
    
    /// Iterate over stagUserInfo dictionary and returns first studentId, else nil
    public func getStudentId() -> String? {
        for info in stagUserInfo {
            if (info.studentId != nil) {
                return info.studentId
            }
        }
        
        return nil
    }
    
    /// Iterate over stagUserInfo dictionary and returns first teacherId, else nil
    public func getTeacherId() -> Int? {
        for info in stagUserInfo {
            if (info.teacherId != nil) {
                return info.teacherId
            }
        }
        
        return nil
    }
}

struct StagUserInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case role = "role"
        case studentId = "osCislo"
        case teacherId = "ucitIdno"
        case username = "userName"
    }
    
    
    let role: String
    let studentId: String?
    let teacherId: Int?
    let username: String
}

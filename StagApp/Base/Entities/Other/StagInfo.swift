import Foundation

/// Entity for user. Created in ``ExternalLoginResult``
struct StagInfo: Decodable {
    
    /// Fields mappping
    enum CodingKeys: String, CodingKey {
        case firstnam = "jmeno"
        case lastname = "prijmeni"
        case email = "email"
        case stagUserInfo = "stagUserInfo"
    }
    
    
    /// User's firstname
    let firstnam: String?
    
    
    /// User's lastname
    let lastname: String?
    
    /// User's email
    let email: String?
    
    /// User's additional info
    let stagUserInfo: [StagUserInfo]
    
    
    /// Iterate over stagUserInfo dictionary and returns first studentId, else nil
    /// - Returns: first studentId in stagUserInfo, else nil
    public func getStudentId() -> String? {
        for info in stagUserInfo {
            if (info.studentId != nil) {
                return info.studentId
            }
        }
        
        return nil
    }
    
    
    /// Iterate over stagUserInfo dictionary and returns first teacherId, else nil
    /// - Returns: first teacherId in stagUserInfo, else nil
    public func getTeacherId() -> Int? {
        for info in stagUserInfo {
            if (info.teacherId != nil) {
                return info.teacherId
            }
        }
        
        return nil
    }
}

/// Nested entity in ``StagInfo``
struct StagUserInfo: Decodable {
    
    /// Fields mapping
    enum CodingKeys: String, CodingKey {
        case role = "role"
        case studentId = "osCislo"
        case teacherId = "ucitIdno"
        case username = "userName"
    }
    
    
    /// User's role
    let role: String
    
    /// User's student ID
    let studentId: String?
    
    /// User's teacher ID
    let teacherId: Int?
    
    /// User's username
    let username: String
}

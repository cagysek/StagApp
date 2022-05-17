import Foundation


/// Entity for API response `fetchUserLogin()`
struct LoginResult: Decodable {
    
    /// API reponse fields mapping
    enum CodingKeys: String, CodingKey {
        case role = "role"
        case studentId = "osCislo"
        case teacherId = "ucitIdno"
        case username = "userName"
        case cookie = "cookie"
    }
    
    
    /// User's role
    let role: String
    
    /// User's student ID
    let studentId: String?
    
    /// User's teacher ID
    let teacherId: Int?
    
    /// User's username
    let username: String
    
    /// User's cookie
    var cookie: String?
    
}

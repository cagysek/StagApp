import Foundation


/// Entity for API response `fetchTeacherInfo()`
public struct TeacherApi: Decodable {
    
    /// API response fields mapping
    enum CodingKeys: String, CodingKey {
        case id = "ucitIdno"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
    }
    
    /// Teacher's ID
    let id: Int
    
    /// Teacher's firstname
    let firstname: String
    
    /// Teacher's lastname
    let lastname: String
    
    /// Teacher's titles before name
    let titleBefore: String?
    
    /// Teacher's titles after name
    let titleAfter: String?
    
    
    /// Returns formatted teacher name with titles
    /// - Returns: formatted teacher name with titles
    public func getFormattedName() -> String {
        return ("\(self.firstname) \(self.lastname)").addTitles(titleBefore: self.titleBefore, titleAfter: self.titleAfter)
    }
}

import Foundation


/// Entity for map fetchSubject from ``StagService``
struct SubjectApi: Codable {
    
    
    /// API response fields mapping
    enum CodingKeys: String, CodingKey {
        case department = "katedra"
        case short = "zkratka"
        case year = "rok"
        case credits = "kredity"
        case name = "nazev"
        case type = "statut"
        case acknowledged = "uznano"
    }
    
    
    /// Subject's department
    let department: String?
    
    /// Subject's title shortcut
    let short: String
    
    /// Subject's study year
    let year: String
    
    /// Subject's credits
    let credits: Int
    
    /// Subject's title
    let name: String
    
    /// Subject's type (lecture, exam, seminar, exercise)
    let type: String
    
    /// Is subject acknowledged
    let acknowledged: String
}

/// Entity for map root fetchSubject from ``StagService``
struct RootSubject: Codable {
    
    /// API response fields mapping
    enum CodingKeys: String, CodingKey {
        case subjectResult = "predmetStudenta"
    }
    
    
    /// Root field from API
    let subjectResult: [SubjectApi]
}

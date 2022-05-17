import Foundation

/// Entity for API response `fetchSubjectStudents()`
struct SubjectStudent: Decodable {
    
    /// API reponse fields mapping
    enum CodingKeys: String, CodingKey {
        case id = "osCislo"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case faculty = "fakultaSp"
        case fieldOfStudy = "nazevSp"
        case studyYear = "rocnik"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
    }
    
    /// Student's ID
    let id: String
    
    /// Student's firstname
    let firstname: String
    
    /// Student's lastname
    let lastname: String
    
    /// Student's faculty
    let faculty: String
    
    /// Student's field of study
    let fieldOfStudy: String
    
    /// Student's study year
    let studyYear: String
    
    /// Student's title before name
    let titleBefore: String?
    
    /// Student's title after name
    let titleAfter: String?
    
    
    /// Returns student's formatted name with titles
    /// - Returns: student's formatted name with titles
    public func getFormattedName() -> String {
        return ("\(self.firstname) \(self.lastname)").addTitles(titleBefore: self.titleBefore, titleAfter: self.titleAfter)
    }
    
}

/// Entity for API root response `fetchSubjectStudents()`
struct SubjectStudentRoot: Decodable {
    
    /// API reponse fields mapping
    enum CodingKeys: String, CodingKey {
        case subjectStudents = "studentPredmetu"
    }
    
    /// API response root
    let subjectStudents: [SubjectStudent]
}

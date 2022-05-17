import Foundation


/// Entity for map response  getStudentInfo from ``StagService``
struct StudentInfo: Codable {
    
    
    /// API response mapping
    enum CodingKeys: String, CodingKey {
        case studentId = "osCislo"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
        case username = "userName"
        case studyProgram = "nazevSp"
        case faculty = "fakultaSp"
        case studyYear = "rocnik"
        case email = "email"
        case studyType = "typSp"
    }
    
    
    /// Student's ID
    let studentId: String
    
    /// Student's firstname
    let firstname: String
    
    /// Student's lastname
    let lastname: String
    
    /// Student's title before name
    let titleBefore: String?
    
    /// Student's title after name
    let titleAfter: String?
    
    /// Student's username
    let username: String
    
    /// Student's study program
    let studyProgram: String
    
    /// Student's faculty
    let faculty: String
    
    /// Student's study year
    let studyYear: String
    
    /// Student's email
    let email: String
    
    /// Student's study type
    let studyType: String
    

    /// Returns student full name with titles
    /// - Returns: student full name with titles
    public func getStudentFullNameWithTitles() -> String {
        var fullname = ""
        
        if (self.titleBefore != nil && !self.titleBefore!.isEmpty)
        {
            fullname += self.titleBefore! + " "
        }
        
        fullname += "\(self.firstname) \(self.lastname.capitalized)"
        
        
        if (self.titleAfter != nil && !self.titleAfter!.isEmpty)
        {
            fullname += self.titleAfter!
        }
        
        return fullname;
    }
    
}

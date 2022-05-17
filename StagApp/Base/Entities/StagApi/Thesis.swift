import Foundation


/// Entity for API response `fetchTheses()`
struct Thesis: Decodable, Identifiable {
    
    /// API response fields mapping
    enum CodingKeys: String, CodingKey {
//        case id = "adipidno"
        case title = "temaHlavni"
        case student = "student"
        case assignmentDate = "datumZadani"
        case submissionDate = "planovaneDatumOdevzdani"
        case department = "katedra"
        case type = "typPrace"
        case faculty = "fakulta"
        case supervisor = "vedouciJmeno"
        case opponent = "oponentJmeno"
        case trainer = "skolitelJmeno"
        case consultant = "konzultantZUnivJmeno"
        case studentField = "oborKombinaceStudenta"
        
    }
    
    
    /// Entity unique identifier
    let id = UUID()
    
    /// Thesis’s title
    let title: String
    
    /// Thesis’s student
    let student: ThesisStudent
    
    /// Thesis’s assignment date
    let assignmentDate: ValueProperty?
    
    /// Thesis’s submission date
    let submissionDate: ValueProperty?
    
    /// Thesis’s department
    let department: String
    
    /// Thesis’s type
    let type: String
    
    /// Thesis’s faculty
    let faculty: String
    
    /// Thesis’s supervisor
    let supervisor: String?
    
    /// Thesis’s opponent
    let opponent: String?
    
    /// Thesis’s trainer
    let trainer: String?
    
    /// Thesis’s consultant
    let consultant: String?
    
    /// Thesis’s student study field
    let studentField: String
    
    
}

/// Entity for nested field `student` in ``Thesis``
struct ThesisStudent: Decodable {
    
    /// API response fields mapping
    enum CodingKeys: String, CodingKey {
        case studentId = "osCislo"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
        case username = "userName"
    }
    
    
    /// Thesis student's ID
    let studentId: String
    
    /// Thesis student's firstname
    let firstname: String
    
    /// Thesis student's lastname
    let lastname: String
    
    /// Thesis student's title before name
    let titleBefore: String?
    
    /// Thesis student's title after name
    let titleAfter: String?
    
    /// Thesis student's username
    let username: String?
    
    
    /// Returns student full name with titles
    /// - Returns: student full name with titles
    public func getFullNameWithTitles() -> String {
        var fullname = ""
        
        if (self.titleBefore != nil && !self.titleBefore!.isEmpty)
        {
            fullname += self.titleBefore! + " "
        }
        
        fullname += "\(self.firstname) \(self.lastname.capitalized)"
        
        
        if (self.titleAfter != nil && !self.titleAfter!.isEmpty)
        {
            fullname += " \(self.titleAfter!)"
        }
        
        return fullname;
    }
}

/// Entity for API root response `fetchTheses()`
struct ThesesRoot: Decodable {
    
    /// API response fields mapping
    enum CodingKeys: String, CodingKey {
        case theses = "kvalifikacniPrace"
    }
    
    /// API response root
    let theses: [Thesis]
}

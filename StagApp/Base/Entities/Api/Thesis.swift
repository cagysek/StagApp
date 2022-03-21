//
//  Thesis.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.03.2022.
//

import Foundation

struct Thesis: Decodable, Identifiable {
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
    
    
    let id = UUID()
    let title: String
    let student: ThesisStudent
    let assignmentDate: ValueProperty?
    let submissionDate: ValueProperty?
    let department: String
    let type: String
    let faculty: String
    let supervisor: String?
    let opponent: String?
    let trainer: String?
    let consultant: String?
    let studentField: String
    
    
}


struct ThesisStudent: Decodable {
    enum CodingKeys: String, CodingKey {
        case studentId = "osCislo"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
        case username = "userName"
    }
    
    let studentId: String
    let firstname: String
    let lastname: String
    let titleBefore: String?
    let titleAfter: String?
    let username: String?
    
    
    /**
        Returns student full name with titles
     */
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

struct ThesesRoot: Decodable {
    enum CodingKeys: String, CodingKey {
        case theses = "kvalifikacniPrace"
    }
    
    let theses: [Thesis]
}

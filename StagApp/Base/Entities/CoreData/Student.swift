import Foundation
import CoreData

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
    case invalidMapper
}


@objc(Student)
/// Extension of Core Data class ``Student``
class Student: NSManagedObject, Decodable {
    
    /// fields mapping
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
    
    
    /// Constructor for creation object from custom decoder
    /// - Parameter decoder: custom decoder
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.firstname = try container.decode(String?.self, forKey: .firstname)
        self.lastname = try container.decode(String?.self, forKey: .lastname)
        self.studentId = try container.decode(String?.self, forKey: .studentId)
        self.titleBefore = try container.decode(String?.self, forKey: .titleBefore)
        self.titleAfter = try container.decode(String?.self, forKey: .titleAfter)
        self.username = try container.decode(String?.self, forKey: .username)
        self.studyProgram = try container.decode(String?.self, forKey: .studyProgram)
        self.faculty = try container.decode(String?.self, forKey: .faculty)
        self.studyYear = try container.decode(String?.self, forKey: .studyYear)
        self.email = try container.decode(String?.self, forKey: .email)
        self.studyType = try container.decode(String?.self, forKey: .studyType)
    }
    
    
    
    /// Returns student full name with titles
    /// - Returns: student full name with titles
    public func getStudentFullNameWithTitles() -> String {
        var fullname = ""
        
        if (self.titleBefore != nil && !self.titleBefore!.isEmpty)
        {
            fullname += self.titleBefore! + " "
        }
        
        fullname += "\(self.firstname ?? "") \(self.lastname?.capitalized ?? "")"
        
        
        if (self.titleAfter != nil && !self.titleAfter!.isEmpty)
        {
            fullname += self.titleAfter!
        }
        
        return fullname;
    }
    
    
    /// Returns required credits count for study
    /// - Returns: required credits count for study
    public func getTotalCreditCount() -> Int {
        if (self.studyType == "B") {
            return 180
        }
        else if (self.studyType == "N") {
            return 120
        }
        
        return 300
    }
}

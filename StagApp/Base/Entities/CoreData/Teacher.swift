import Foundation
import CoreData


@objc(Teacher)
/// Extension of Core Data class ``Student``
class Teacher: NSManagedObject, Decodable {
    
    /// fields mapping
    enum CodingKeys: String, CodingKey {
        case teacherId = "ucitIdno"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
        case email = "email"
    }
    
    /// Constructor for creation object from custom decoder
    /// - Parameter decoder: custom decoder
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.teacherId = try container.decode(Int32.self, forKey: .teacherId)
        self.lastname = try container.decode(String?.self, forKey: .lastname)
        self.firstname = try container.decode(String?.self, forKey: .firstname)
        self.titleBefore = try container.decode(String?.self, forKey: .titleBefore)
        self.titleAfter = try container.decode(String?.self, forKey: .titleAfter)
        self.email = try container.decode(String?.self, forKey: .email)
    }
    
}

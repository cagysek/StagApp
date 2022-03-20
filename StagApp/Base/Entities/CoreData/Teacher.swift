//
//  Teacher.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 20.03.2022.
//

import Foundation
import CoreData


@objc(Teacher)
class Teacher: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case teacherId = "ucitIdno"
        case firstname = "jmeno"
        case lastname = "prijmeni"
        case titleBefore = "titulPred"
        case titleAfter = "titulZa"
        case email = "email"
    }
    
    
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

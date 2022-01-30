//
//  JSONDecoder.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 25.01.2022.
//

import Foundation
import CoreData


extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}

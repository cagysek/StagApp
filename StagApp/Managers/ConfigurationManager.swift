//
//  ConfigurationManager.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 16.07.2022.
//

import Foundation


enum ConfigurationManager {
    static func stringValue(forKey key: String) -> String {

        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String
        else {
          print("Invalid value or undefined key")
            return ""
        }
        return value
      }
}

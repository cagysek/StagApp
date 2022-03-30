//
//  Time.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.02.2022.
//

import Foundation

public struct ValueProperty: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
    }
    
    let value: String
}

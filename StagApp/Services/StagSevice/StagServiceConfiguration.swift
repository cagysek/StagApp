//
//  StagServiceConfiguration.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 14.03.2022.
//

import Foundation

struct StagServiceConfiguration {
    var baseUri: String
    var language: String
    var cookie: String
    
    init(baseUri: String, language: String = "cs", cookie: String = "") {
        self.baseUri = baseUri
        self.language = language
        self.cookie = cookie
    }
}

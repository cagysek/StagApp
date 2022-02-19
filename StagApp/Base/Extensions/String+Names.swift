//
//  String+names.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.02.2022.
//

import Foundation

extension String {
    
    public func addTitles(titleBefore: String?, titleAfter: String?) -> String {
        
        var titledName = ""
        
        if (!(titleBefore ?? "").isEmpty) {
            titledName += titleBefore! + " "
        }
        
        titledName += self
        
        if (!(titleAfter ?? "").isEmpty) {
            titledName += " " + titleAfter!
        }
        
        return titledName
    }
}

extension StringProtocol {
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}

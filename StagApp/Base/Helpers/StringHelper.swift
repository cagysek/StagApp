//
//  StringHelper.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 09.01.2022.
//

import Foundation

struct StringHelper {
    
    public static func concatStringsToOne(strings: String..., separatorOnFirstPosition: Bool = false, separator: String = " ∙ ") -> String {
        var result = "";
        
        for string in strings
        {
            if (separatorOnFirstPosition || !result.isEmpty)
            {
                result += separator
            }
            
            result += string
        }
        
        return result;
    }
}

//
//  AlertContext.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.04.2022.
//

import Foundation
import SwiftUI


struct AlertData {
    let title: Text
    let msg: Text
    
    static let empty = AlertData(title: "", msg: "")
    
    init(title: String = "", msg: String = "", arguments: CVarArg...) {
        
        let language = LanguageService.shared.language
        
        // locale texts by language
        self.title = Text(title.localized(language))
        self.msg = Text(msg.localized(language, args: arguments))
    }
}

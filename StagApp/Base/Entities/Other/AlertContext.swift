import Foundation
import SwiftUI


/// Entity for holding alers data
struct AlertData {
    
    /// Alert title
    let title: Text
    
    /// Alert message
    let msg: Text
    
    static let empty = AlertData(title: "", msg: "")
    
    init(title: String = "", msg: String = "", arguments: CVarArg...) {
        
        let language = LanguageService.shared.language
        
        // locale texts by language
        self.title = Text(title.localized(language))
        self.msg = Text(msg.localized(language, args: arguments))
    }
}

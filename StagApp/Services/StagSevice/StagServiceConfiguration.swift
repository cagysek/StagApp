import Foundation


/// Stag API configuration
struct StagServiceConfiguration {
    
    /// Base WS domain
    var baseUri: String
    
    /// Response language
    var language: String
    
    /// Authorization cookie
    var cookie: String
    
    init(baseUri: String, language: String = "cs", cookie: String = "") {
        self.baseUri = baseUri
        self.language = language
        self.cookie = cookie
    }
}

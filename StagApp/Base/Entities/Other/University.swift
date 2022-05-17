import Foundation

/// Entity for  faculty representation
class University: Identifiable {
    
    /// Faculty's ID
    let id: Int
    
    /// Faculty's title
    let title: String
    
    /// Faculty's WS domain
    let url: String
    
    /// Path to small faculty's logo
    let smallLogoImagePath: String
    
    /// Path to big faculty's logo
    let bigLogoImagePath: String
    
    
    init(id: Int, title: String, url: String, smallLogoImagePath: String, bigLogoImagePath: String) {
        self.id = id
        self.title = title
        self.url = url
        self.smallLogoImagePath = smallLogoImagePath
        self.bigLogoImagePath = bigLogoImagePath
    }
}

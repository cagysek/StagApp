import Foundation


/// General entity for nested fields in API responses
public struct ValueProperty: Decodable {
    
    /// API response fields mapping
    enum CodingKeys: String, CodingKey {
        case value = "value"
    }
    
    /// Field value
    let value: String
}

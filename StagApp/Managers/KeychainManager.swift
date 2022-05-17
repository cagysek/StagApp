import Foundation
import Security


/// Protocol to define functions for Keychain operations
protocol IKeychainManager {
    
    /// Saves auth cookie to keychain
    /// - Parameter cookieValue: cookie value
    /// - Returns: result of operation
    func saveCookie(cookieValue: String) -> Bool
    
    /// Removes aut cookie from keychain
    /// - Returns: result of operation
    func removeCookie() -> Bool
    
    /// Returns auth cookie from keychain
    /// - Returns: auth cookie if exists, else `nil`
    func getCookie() -> String?
    
    
    /// Saves username to keychain
    /// - Parameter username: usename
    /// - Returns: result of operation
    func saveUsername(username: String) -> Bool
    
    /// Removes username from keychain
    /// - Returns: result of operation
    func removeUsername() -> Bool
    
    /// Return username of logged user
    /// - Returns: username of logged user
    func getUsername() -> String?
    
}

/// Implementation of ``IKeychainManager``
struct KeychainManager: IKeychainManager {
    
    private let COOKIE_KEY: String = "cookie"
    private let USERNAME_KEY: String = "username"
    
    
    public func saveUsername(username: String) -> Bool {
        return self.save(for: self.USERNAME_KEY, data: username)
    }
    
    public func removeUsername() -> Bool {
        return self.remove(for: self.USERNAME_KEY)
    }
    
    public func getUsername() -> String? {
        return self.getValue(for: self.USERNAME_KEY)
    }
    
    
    public func saveCookie(cookieValue: String) -> Bool {
        return self.save(for: self.COOKIE_KEY, data: cookieValue)
    }
    
    public func removeCookie() -> Bool {
        return self.remove(for: self.COOKIE_KEY)
    }
    
    public func getCookie() -> String? {
        return self.getValue(for: self.COOKIE_KEY)
    }
    
    
    /// Returns value from keychain
    /// - Parameter key: value key
    /// - Returns: stored value for key, if not exists `nil`
    private func getValue(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               
               let cookieData = existingItem[kSecValueData as String] as? Data,
               let cookie = String(data: cookieData, encoding: .utf8)
            {
               return cookie
            }
        }
        
        return nil
    }
    
    
    /// Remove value for specific key
    /// - Parameter key: key to delete
    /// - Returns: result of operation
    private func remove(for key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
        ]
        
        if SecItemDelete(query as CFDictionary) == noErr {
            return true
        } else {
            return false
        }
    }
    
    /// Save value for key
    /// - Parameters:
    ///   - key: key to save
    ///   - data: value to save
    /// - Returns: result of operation
    private func save(for key: String, data: String) -> Bool {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data.data(using: .utf8)!,
        ]

        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            return true
        } else {
            return false
        }
    }
}

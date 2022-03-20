//
//  KeychainManager.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 14.03.2022.
//

import Foundation
import Security


protocol IKeychainManager {
    func saveCookie(cookieValue: String) -> Bool
    func removeCookie() -> Bool
    func getCookie() -> String?
    func saveUsername(username: String) -> Bool
    func removeUsername() -> Bool
    func getUsername() -> String?
    
}

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

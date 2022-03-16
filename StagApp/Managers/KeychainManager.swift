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
}

struct KeychainManager: IKeychainManager {
    
    private let COOKIE_INDENTIFICATOR: String = "cookie"
    
    
    public func saveCookie(cookieValue: String) -> Bool {
        
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: self.COOKIE_INDENTIFICATOR,
            kSecValueData as String: cookieValue.data(using: .utf8)!,
        ]

        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            return true
        } else {
            return false
        }
    }
    
    public func removeCookie() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: self.COOKIE_INDENTIFICATOR,
        ]
        
        if SecItemDelete(query as CFDictionary) == noErr {
            return true
        } else {
            return false
        }
    }
    
    public func getCookie() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: self.COOKIE_INDENTIFICATOR,
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
}

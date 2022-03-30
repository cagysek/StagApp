//
//  ExternalLoginResult.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 28.03.2022.
//

import Foundation


struct ExternalLoginResult {

    private let stagUserTicket: String?
    private let stagUserName: String?
    private let stagUserRole: String?
    private var stagUserInfo: StagInfo? = nil
    
    
    init (stagUserTicket: String?, stagUserName: String?, stagUserRole: String?, stagUserInfo: String?) {
        self.stagUserTicket = stagUserTicket
        self.stagUserName = stagUserName
        self.stagUserRole = stagUserRole
        self.stagUserInfo = self.convertStagUserInfo(stagUserInfo: stagUserInfo)
    }

    public func getStagUserTicket() -> String? {
        return self.stagUserTicket
    }
    
    public func getStagUserName() -> String? {
        return self.stagUserName
    }
    
    public func getStagUserRole() -> String? {
        return self.stagUserRole
    }
    
    public func getStagUserInfo() -> StagInfo? {
        return self.stagUserInfo
    }
    
    /// Converts Base64 atribut to string
    private func getDecodedStagInfo(stagUserInfo: String?) -> String? {
        
        if (stagUserInfo == nil)
        {
            return nil
        }
        
        guard let data = Data(base64Encoded: stagUserInfo!) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    
    private func convertStagUserInfo(stagUserInfo: String?)-> StagInfo? {
        
        guard let decodedStagInfo = self.getDecodedStagInfo(stagUserInfo: stagUserInfo) else {
            return nil
        }
        
        let data = Data(decodedStagInfo.utf8)
        
        do {
            return try JSONDecoder().decode(StagInfo.self, from: data)
        } catch {
            print(error)
        }
        
        return nil
    }
    
    /// Validate external login result
    /// External login is success only if all properties are set
    public func isValid() -> Bool {
        return self.getStagUserTicket() != nil && self.getStagUserInfo() != nil && self.stagUserRole != nil && self.stagUserName != nil
    }
}


import Foundation


/// Entity holds external login values
struct ExternalLoginResult {
    
    /// User's ticket
    private let stagUserTicket: String?
    
    /// User's username
    private let stagUserName: String?
    
    /// User's role
    private let stagUserRole: String?
    
    /// User's info
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
    /// - Parameter stagUserInfo: user's info coded in `Base64`
    /// - Returns: string which holds json, if error occurs `nil`
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
    
    
    /// Converts user's data from json to ``StagInfo``
    /// - Parameter stagUserInfo: user's info coded in `Base64`
    /// - Returns: instance of ``StagInfo``, if error occurs `nil`
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
    /// - Returns: true if all properties are set, or false
    public func isValid() -> Bool {
        return self.getStagUserTicket() != nil && self.getStagUserInfo() != nil && self.stagUserRole != nil && self.stagUserName != nil
    }
}


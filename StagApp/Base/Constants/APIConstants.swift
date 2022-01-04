//
//  APIConstants.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation

enum APIConstants {
    static let baseUrl = "https://stag-ws.zcu.cz/ws/services/rest2/"
    
    static let schedule = "rozvrhy/getRozvrhByStudent"
    
    static let marks = "znamky/getZnamkyByStudent"
    
    static let studentInfo = "student/getStudentInfo?lang=cs&osCislo=A19N0025P&outputFormat=JSON"
}

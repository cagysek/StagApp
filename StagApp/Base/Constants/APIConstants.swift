//
//  APIConstants.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation

enum APIConstants {
    static let baseUrl = "https://stag-demo.zcu.cz/ws/services/rest2/"
//    static let baseUrl = "https://stag-ws.zcu.cz/ws/services/rest2/"

    
    static let schedule = "rozvrhy/getRozvrhByStudent"
    
    static let subjectResults = "znamky/getZnamkyByStudent"
    
    static let studentInfo = "student/getStudentInfo"
    
    static let subjects = "predmety/getPredmetyByStudent"
    
    static let scheduleActions = "rozvrhy/getRozvrhByStudent"
    
    static let exams = "terminy/getTerminyProStudenta"
    
    static let examsLogIn = "terminy/zapisStudentaNaTermin"
    
    static let examsLogOut = "terminy/odhlasStudentaZTerminu"
}

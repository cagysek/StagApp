//
//  APIConstants.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation


/// Definition of IS/STAG API endpoints
enum StagAPIConstants {
    
    static let schedule = "rozvrhy/getRozvrhByStudent"
    
    static let subjectResults = "znamky/getZnamkyByStudent"
    
    static let studentInfo = "student/getStudentInfo"
    
    static let subjects = "predmety/getPredmetyByStudent"
    
    static let studentScheduleActions = "rozvrhy/getRozvrhByStudent"
    
    static let exams = "terminy/getTerminyProStudenta"
    
    static let examsLogIn = "terminy/zapisStudentaNaTermin"
    
    static let examsLogOut = "terminy/odhlasStudentaZTerminu"
    
    static let subjectDetailInfo = "/predmety/getPredmetInfo"
    
    static let subjectStudents = "/student/getStudentiByRoakce"
    
    static let login = "/help/getStagUserForActualUser"
    
    static let teacherInfo = "/ucitel/getUcitelInfo"
    
    static let teacherScheduleActions = "/rozvrhy/getRozvrhByUcitel"
    
    static let Theses = "/kvalifikacniprace/getKvalifikacniPrace"
}

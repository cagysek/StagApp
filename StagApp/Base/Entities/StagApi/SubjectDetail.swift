import Foundation

/// Entity for API response `fetchSubjectDetailInfo()`
struct SubjectDetail: Decodable {
    
    /// API response fields mapping
    enum CodingKeys: String, CodingKey {
        case department = "katedra"
        case short = "zkratka"
        case title = "nazev"
        case credits = "kreditu"
        case garants = "garanti"
        case speakers = "prednasejici"
        case practitioners = "cvicici"
        case seminarTeachers = "seminarici"
        case requiredSubjects = "podminujiciPredmety"
        case literature = "literatura"
        case lectureCount = "jednotekPrednasek"
        case practiseCount = "jednotekCviceni"
        case seminarCount = "jednotekSeminare"
        case goal = "anotace"
        case examType = "typZkousky"
        case creaditBeforeExam = "maZapocetPredZk"
        case examForm = "formaZkousky"
        case requirements = "pozadavky"
        case content = "prehledLatky"
        case prerequisites = "predpoklady"
        case subjectUrl = "predmetUrl"
    }
    
    /// Subject's department
    let department: String
    
    /// Subject's title shortcut
    let short: String
    
    /// Subject's title
    let title: String
    
    /// Subject's credits
    let credits: Int
    
    /// Subject's garants
    let garants: String
    
    /// Subject's speakers
    let speakers: String
    
    /// Subject's practitioners
    let practitioners: String
    
    /// Subject's seminar teachers
    let seminarTeachers: String
    
    /// Subject's required subjects
    let requiredSubjects: String?
    
    /// Subject's literature
    let literature: String?
    
    /// Subject's lecture count
    let lectureCount: Int
    
    /// Subject's practise count
    let practiseCount: Int
    
    /// Subject's seminar count
    let seminarCount: Int
    
    /// Subject's goal
    let goal: String?
    
    /// Subject's exam type
    let examType: String
    
    /// Subject's credit before exam
    let creaditBeforeExam: String?
    
    /// Subject's exam form
    let examForm: String?
    
    /// Subject's requirements
    let requirements: String?
    
    /// Subject's content
    let content: String?
    
    /// Subject's prerequisites
    let prerequisites: String?
    
    /// Subject's courseware url
    let subjectUrl: String?
}

//
//  SubjectStudent.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 06.03.2022.
//

import Foundation


struct SubjectStudent: Decodable {
    
}


struct SubjectStudentRoot: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case subjectStudents = "studentPredmetu"
    }
    
    let subjectStudents: [SubjectStudent]
}

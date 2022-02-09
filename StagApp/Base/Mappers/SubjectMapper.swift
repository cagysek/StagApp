//
//  SubjectMapper.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 07.02.2022.
//

import Foundation
import CoreData

struct SubjectMapper {
    
    
    public func mapNewSubjectFromSubjectResult(subjectResult: SubjectResult, subject: Subject) -> Subject {
        
        subject.department = subjectResult.department
        subject.short = subjectResult.subjectShort
        subject.year = subjectResult.year
        subject.semester = subjectResult.semester
        subject.examTeacher = subjectResult.examTeacher
        subject.examPoints = subjectResult.examPoints
        subject.examDate = subjectResult.examDate
        subject.examAttempt = subjectResult.examAttempt
        subject.examGrade = subjectResult.examGrade
        subject.creditBeforeExamTeacher = subjectResult.creditBeforeExamTeacher
        subject.creditBeforeExamDate = subjectResult.creditBeforeExamDate
        subject.creditBeforeExamGrade = subjectResult.creditBeforeExamGrade
        subject.creditBeforeExamAttempt = subjectResult.creditBeforeExamAttempt
        
        return subject
    }
}

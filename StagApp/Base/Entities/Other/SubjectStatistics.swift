//
//  SubjectStatistics.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.03.2022.
//

import Foundation


struct SubjectStatistics {
    
    private let currentCredits: Int
    private let totalCredits: Int
    private let average: Double
    private let totalSubjects: Int
    private let completedSubjects: Int
    
    init(currentCredits: Int, totalCredits: Int, average: Double, totalSubjects: Int, completedSubjects: Int) {
        self.currentCredits = currentCredits
        self.totalCredits = totalCredits
        self.average = average
        self.totalSubjects = totalSubjects
        self.completedSubjects = completedSubjects
    }
    
    
    public func getCurrentCredits() -> Int {
        return self.currentCredits
    }
    
    public func getTotalCredits() -> Int {
        return self.totalCredits
    }
    
    public func getAverage() -> Double {
        return self.average
    }
    
    public func getAverageString() -> String {
        if (self.average.isNaN) {
            return "-"
        }
        
        return String(format: "%.2f", self.average)
    }
    
    public func getCredits() -> Int {
        return self.totalCredits
    }
    
    public func getTotalSubjects() -> Int {
        return self.totalSubjects
    }
    
    public func getCompletedSubjects() -> Int {
        return self.completedSubjects
    }


}

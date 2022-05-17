import Foundation

/// Protocol defines Subject statistics calculator methods
protocol ISubjectStatisticsCaltulator {
    
    
    /// Returns statistics for given subejcts
    /// - Parameter subjects: array of ``Subject`` for calculation statistics
    /// - Returns: returns ``SubjectStatistics``
    func getStatistics(subjects: [Subject]) -> SubjectStatistics
}


/// Implementation of subject statistics calculator, implements ``ISubjectStatisticsCaltulator``
struct SubjectStatisticsCalculator: ISubjectStatisticsCaltulator {
    
    /// Array with accepted marks
    let ACCEPTED_MARKS: [String] = ["1", "2", "3", "4", "S"]
    
    /// Returns statistics for given subejcts
    /// - Parameter subjects: array of ``Subject`` for calculation statistics
    /// - Returns: returns ``SubjectStatistics``
    public func getStatistics(subjects: [Subject]) -> SubjectStatistics {
        
        var totalCredits = 0
        var currentCredits = 0;
        var totalSubjects = 0;
        var completedSubjects = 0
        var tmpAvgCredits = 0;
        var tmpAvg = 0;
        
        for subject in subjects {
            
            let credits = Int(subject.credits)
            
            totalCredits += credits
            totalSubjects += 1
            
            guard let grade = subject.examGrade else {
                continue
            }
            
            if (subject.examDate != nil && self.ACCEPTED_MARKS.contains(grade)) {
                
                // 4 = failure, calculated to average
                if (grade != "4") {
                    currentCredits += credits
                    completedSubjects += 1
                }
                
                // credits are not calculated to average
                if (grade != "S") {
                    tmpAvg += credits * (Int(grade) ?? 0)
                    tmpAvgCredits += credits
                }
            }
        }
        
        let avg: Double = Double(tmpAvg) / Double(tmpAvgCredits)
        
        return SubjectStatistics(currentCredits: currentCredits, totalCredits: totalCredits, average: avg, totalSubjects: totalSubjects, completedSubjects: completedSubjects)
    }
    
}

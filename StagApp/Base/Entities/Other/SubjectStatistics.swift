import Foundation


/// Entity represents subjects stattistics
struct SubjectStatistics {
    
    /// Curent credits count
    private let currentCredits: Int
    
    /// Total credits count to get
    private let totalCredits: Int
    
    /// Average
    private let average: Double
    
    /// Total subjects count
    private let totalSubjects: Int
    
    /// Total completed subject count
    private let completedSubjects: Int
    
    init(currentCredits: Int, totalCredits: Int, average: Double, totalSubjects: Int, completedSubjects: Int) {
        self.currentCredits = currentCredits
        self.totalCredits = totalCredits
        self.average = average
        self.totalSubjects = totalSubjects
        self.completedSubjects = completedSubjects
    }
    
    
    /// Returns current credits count
    /// - Returns: current credits count
    public func getCurrentCredits() -> Int {
        return self.currentCredits
    }
    
    
    /// Return total credits count to get
    /// - Returns: total credits count to get
    public func getTotalCredits() -> Int {
        return self.totalCredits
    }
    
    
    /// Returns average
    /// - Returns: average
    public func getAverage() -> Double {
        return self.average
    }
    
    
    /// Returns average as string
    /// - Returns: average as string
    public func getAverageString() -> String {
        if (self.average.isNaN) {
            return "-"
        }
        
        return String(format: "%.2f", self.average)
    }
    
    /// Return total credits count
    /// - Returns: total credits count
    public func getCredits() -> Int {
        return self.totalCredits
    }
    
    /// Returns total subject count
    /// - Returns: total subject count
    public func getTotalSubjects() -> Int {
        return self.totalSubjects
    }
    
    /// Returns completed subject count
    /// - Returns: completed subject sount
    public func getCompletedSubjects() -> Int {
        return self.completedSubjects
    }


}

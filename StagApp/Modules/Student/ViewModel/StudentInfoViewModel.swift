import Foundation

/// Protocol for define view model functions
protocol IStudentInfoViewModel: ObservableObject {
    
    /// Loads students data
    func getUserData()
    
    /// Loads student's subject by year
    /// - Parameter year: year to load
    func updateSubjectData(year: Int)
    
    /// Gets years when student studied
    /// - Returns: array of years
    func getStudyYears() -> Array<Int>
    
    /// Returns student statistics
    /// - Returns: student statistics
    func getTotalStatistics() -> SubjectStatistics
}


/// View model for ``StudentScreen``
final class StudentInfoViewModel: IStudentInfoViewModel {
    @Published var studentInfoData: StudentInfo? = nil
    
    @Published var winterSubjects: [Subject] = []
    @Published var summerSubjects: [Subject] = []
    
    @Published var studentInfo: Student? = nil
    
    @Published var yearStatistics: SubjectStatistics? = nil
    
    private let dataService: IDataManager
    
    private let subjectRepository: ISubjectRepository
    
    private let subjectStatisctisCalculator: ISubjectStatisticsCaltulator
    
    init(dataManager: IDataManager, subjectRepository: ISubjectRepository, subjectStatisticsCalculator: ISubjectStatisticsCaltulator) {
        self.subjectRepository = subjectRepository
        
        self.dataService = dataManager
        self.subjectStatisctisCalculator = subjectStatisticsCalculator
    }
    
    public func getUserData() {
        self.studentInfo = CoreDataManager.getStudentInfo()
    }
    
    public func updateSubjectData(year: Int)
    {
        self.winterSubjects = self.subjectRepository.getSubjects(year: year, semester: ESemester.WINTER.rawValue)
        self.summerSubjects = self.subjectRepository.getSubjects(year: year, semester: ESemester.SUMMER.rawValue)
        
        self.yearStatistics = self.subjectStatisctisCalculator.getStatistics(subjects: self.winterSubjects + self.summerSubjects)
    }
    
    public func getStudyYears() -> Array<Int> {
        
        guard let studyYears = self.subjectRepository.getStudyYears() else {
            return []
        }
        
        var intYears: Array<Int> = []
        
        for year in studyYears {
            guard let intYear = Int(year["year"] ?? "") else {
                continue
            }
            
            intYears.append(intYear)
        }
        
        
        return intYears
    }
    
    public func getTotalStatistics() -> SubjectStatistics {
        let subjects = self.subjectRepository.get(predicate: nil, sortDescriptors: nil)
        
        return self.subjectStatisctisCalculator.getStatistics(subjects: subjects)
    }
    
    

    
    
}

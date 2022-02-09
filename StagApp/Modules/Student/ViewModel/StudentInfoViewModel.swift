//
//  StudentViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 15.12.2021.
//

import Foundation

protocol StudentInfoViewModel: ObservableObject {
    func getUserData()
}


final class StudentInfoViewModelImpl: StudentInfoViewModel {
    @Published var studentInfoData: StudentInfo? = nil
    
    @Published var winterSubjects: [Subject] = []
    @Published var summerSubjects: [Subject] = []
    
    @Published var studentInfo: Student? = nil
    
    let dataService: IDataManager
    
    let stagService: IStagService
    
    let subjectRepository: ISubjectRepository
    
    init(stagService: IStagService, subjectRepository: ISubjectRepository) {
        self.stagService = stagService
        self.subjectRepository = subjectRepository
        
        self.dataService = DataManager(stagApiService: stagService, subjectRepository: subjectRepository)
        
    }
    
    public func getUserData() {
        self.dataService.syncData()
        
        self.studentInfo = CoreDataManager.getStudentInfo()
//        self.subjects = CoreDataManager.getSubjects(year: year)
//        do {
//            self.studentInfoData = try await stagService.fetchStudentInfo()
//            self.examResults = try await stagService.fetchExamResults()
//        } catch {
//            print(error)
//        }
        
    }
    
    public func updateSubjectData(year: Int)
    {
        self.winterSubjects = self.subjectRepository.getSubjects(year: year, semester: ESemester.WINTER.rawValue)
        self.summerSubjects = self.subjectRepository.getSubjects(year: year, semester: ESemester.SUMMER.rawValue)
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
    
    

    
    
}

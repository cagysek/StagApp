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
    @Published var examResults: [SubjectResult] = []
    @Published var studentInfo: Student? = nil
    
    let dataService: DataManager
    
    let stagService: StagService
    
    init(stagService: StagService) {
        self.stagService = stagService
        
        self.dataService = DataManagerImpl(stagApiService: stagService as! StagServiceImpl)
        
        
    }
    
    public func getUserData() {
        
    
        self.dataService.syncData()
        
        self.studentInfo = CoreDataManager.getStudentInfo()
//        do {
//            self.studentInfoData = try await stagService.fetchStudentInfo()
//            self.examResults = try await stagService.fetchExamResults()
//        } catch {
//            print(error)
//        }
        
    }
    
    

    
    
}

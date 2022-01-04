//
//  StudentViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 15.12.2021.
//

import Foundation

protocol StudentInfoViewModel: ObservableObject {
    func getUserData() async
}

@MainActor
final class StudentInfoViewModelImpl: StudentInfoViewModel {
    @Published private(set) var studentInfoData: StudentInfo? = nil
    
    let stagService: StagService
    
    init(stagService: StagService) {
        self.stagService = stagService
    }
    
    public func getUserData() async {
        do {
            self.studentInfoData = try await stagService.fetchStudentInfo()
        } catch {
            print(error)
        }
        
    }
    
    

    
    
}

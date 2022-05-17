import Foundation


/// Protocol to define public methods for subject detail
protocol ISubjectDetailViewModel: ObservableObject {
    
    /// Load students on subject
    /// - Parameter subjectId: subject to load students
    func loadSubjectStudents(subjectId: Int) async -> Void
    
    /// Loads subject info
    /// - Parameters:
    ///   - department: subject department
    ///   - short: subject title shortcut
    func loadSubjectDetail(department: String, short: String) async -> Void
}


@MainActor
/// View Model for ``SubjectDetailScreen``
class SubjectDetailViewModel: ISubjectDetailViewModel {
    
    /// Published property which holds instance of ``SubjectDetail``
    @Published var subjectDetail: SubjectDetail? = nil
    
    /// Published property wihch holds array of ``SubjectStudent``
    @Published var subjectstudents: [SubjectStudent] = []
    
    let stagService: IStagService
    
    init(stagService: IStagService) {
        self.stagService = stagService
    }
    
    
    public func loadSubjectDetail(department: String, short: String) async -> Void {
        
        do {
            self.subjectDetail = try await self.stagService.fetchSubjectDetailInfo(department: department, short: short)
            
            
        } catch {
            print(error)
        }
        
    }
    
    public func loadSubjectStudents(subjectId: Int) async -> Void {
        do {
            self.subjectstudents = try await self.stagService.fetchSubjectStudents(subjectId: subjectId)
        } catch {
            print(error)
        }
    }
    
}

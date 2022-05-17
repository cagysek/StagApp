import Foundation


/// View Model for ``NoteListScreen``
class NoteListViewModel: ObservableObject {
    
    /// array of loaded notes
    @Published var notes: [Note] = []
    
    let noteRepository: INoteRepository
    let keychainManager: IKeychainManager
    
    init (noteRepository: INoteRepository, keychainManager: IKeychainManager) {
        self.noteRepository = noteRepository
        self.keychainManager = keychainManager
    }
    
    
    @MainActor
    /// Loads notes for logged user
    public func loadNotes() -> Void {
        guard let username = self.keychainManager.getUsername() else {
            return
        }
        
        CoreDataManager.getContext().refreshAllObjects()
        self.notes = self.noteRepository.getByUserName(username: username)
    }
    
    
    /// Removes note from database
    /// - Parameter note: note to remove
    /// - Returns: result of operation
    public func deleteNote(note: Note) -> Bool {
        _ = self.noteRepository.delete(note: note)
        _ = self.noteRepository.saveContext()
        
        return true
    }
    
}

import Foundation

/// Definition of protocol for view model
protocol INoteViewModel: ObservableObject {
    
    /// Inserts new note to database
    /// - Parameters:
    ///   - title: title of note
    ///   - description: description of node
    ///   - includeDate: has note date
    ///   - date: date of note
    /// - Returns: result status
    func insertNewNote(title: String, description: String, includeDate: Bool, date: Date) -> Bool
    
    /// Updated existing note
    /// - Parameter note: updated note
    /// - Returns: result status
    func saveNote(note: Note) -> Bool
}


/// View Model for ``AddNoteView``
class NoteViewModel: INoteViewModel {
    
    @Published var notes: [Note] = []
    
    private let noteRepository: INoteRepository
    
    private let keychainManager: IKeychainManager
    
    init(noteRepository: INoteRepository, keycheinManager: IKeychainManager) {
        self.noteRepository = noteRepository
        self.keychainManager = keycheinManager
    }
    
    
    public func insertNewNote(title: String, description: String, includeDate: Bool, date: Date) -> Bool {
        
        guard let note = self.noteRepository.create() else {
            return false
        }
        
        note.title = title
        note.descriptionText = description
        note.userName = self.keychainManager.getUsername()
        
        if (includeDate) {
            note.date = date
        }
        else
        {
            note.date = nil
        }
        
        _ = self.noteRepository.insert(note)
        _ = self.noteRepository.saveContext()
        
        return true
    }
    
    public func saveNote(note: Note) -> Bool {
        _ = self.noteRepository.insert(note)
        _ = self.noteRepository.saveContext()
        
        return true
    }
}

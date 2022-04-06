//
//  NoteListViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 04.04.2022.
//

import Foundation


class NoteListViewModel: ObservableObject {
    
    @Published var notes: [Note] = []
    
    let noteRepository: INoteRepository
    let keychainManager: IKeychainManager
    
    init (noteRepository: INoteRepository, keychainManager: IKeychainManager) {
        self.noteRepository = noteRepository
        self.keychainManager = keychainManager
    }
    
    @MainActor
    public func loadNotes() -> Void {
        guard let username = self.keychainManager.getUsername() else {
            return
        }
        
        CoreDataManager.getContext().refreshAllObjects()
        self.notes = self.noteRepository.getByUserName(username: username)
    }
    
    public func deleteNote(note: Note) -> Bool {
        _ = self.noteRepository.delete(note: note)
        _ = self.noteRepository.saveContext()
        
        return true
    }
    
}

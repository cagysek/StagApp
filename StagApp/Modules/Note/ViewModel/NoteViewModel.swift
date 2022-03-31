//
//  NoteViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.03.2022.
//

import Foundation

protocol INoteViewModel: ObservableObject {
    func insertNewNote(title: String, description: String, includeDate: Bool, date: Date) -> Bool
}

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
}

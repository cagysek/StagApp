import SwiftUI

/// App screen with list of notes
struct NoteListScreen: View {
    
    @StateObject var vm = NoteListViewModel(noteRepository: NoteRepository(context: CoreDataManager.getContext()), keychainManager: KeychainManager())
    
    @State var showNotesAddSheet: Bool = false
    
    @State var selectedNote: Note? = nil
    
    var body: some View {
        
        ZStack(alignment: .top) {
            Color.defaultBackground
                .ignoresSafeArea()
            
            VStack {
                if (self.vm.notes.isEmpty) {
                    InformationBubble {
                        VStack {
                            Text("overview.no-notes")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                        }
                    }
                    .frame(height: 30)
                    .padding()
                } else {
                    List {
                        ForEach(self.vm.notes, id: \.self) { note in
                            
                            VStack(alignment: .leading) {
                                Text(note.title ?? "")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                Text(note.descriptionText ?? "")
                                    .lineLimit(3)
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    _ = self.vm.deleteNote(note: note)
                                    
                                    self.vm.loadNotes()
                                } label: {
                                    Label("note.delete", systemImage: "trash.fill")
                                }
                            }
                            .onTapGesture {
                                self.selectedNote = note
                                self.showNotesAddSheet.toggle()
                            }
                            
                        }
                    }
                }
            }
            .onAppear {
                self.vm.loadNotes()
            }
        }
        .sheet(isPresented: $showNotesAddSheet, onDismiss: {
            self.vm.loadNotes()
        }) {
            AddNoteView(note: $selectedNote)
                .onTapGesture {
                    hideKeyboard()
                }
        }
        .navigationBarTitle("note.title")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("note.add") {
                self.selectedNote = nil
                self.showNotesAddSheet.toggle()
            }
        }
        
        
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteListScreen()
    }
}

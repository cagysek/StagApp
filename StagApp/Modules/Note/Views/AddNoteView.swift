//
//  AddNoteView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.03.2022.
//

import SwiftUI

struct AddNoteView: View {
    
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var vm = NoteViewModel(noteRepository: NoteRepository(context: CoreDataManager.getContext()), keycheinManager: KeychainManager())
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var showDate: Bool = false
    @State private var calendarId = UUID()
    
    @Binding var note: Note?
    
    
    var body: some View {
        NavigationView {
            
            
            ZStack {
                Color.defaultBackground
                
                ScrollView {
                    VStack {
                        VStack {
                            TextField("note.note-title", text: $title)
                                .font(.body)
                                .frame(height: 30)
                                .padding(.leading, 7)
                                .padding(.top, 6)
                                

                            Divider()
                            
                            CustomTextEditor.init(placeholder: "note.placeholder".localized(LanguageService.shared.language), text: self.$description)
                                .font(.body)
                                .frame(height: 200)
                                .cornerRadius(8)
                                .shadow(color: .shadow, radius: 8)
                                .background()
                         
                        }
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .shadow, radius: 8)
                            

                        
                        VStack {
                            Toggle("note.date", isOn: $showDate)
                                .padding(7)
                            
                            if (showDate) {
                                DatePicker("note.deadline", selection: $date, displayedComponents: [.date])
                                    .padding(7)
                                    .id(calendarId)
                                    .onChange(of: date) { _ in
                                        calendarId = UUID()
                                    }
                            }
                        }
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .shadow, radius: 8)
                        
                        
                        Spacer()
                        
                    }
                    .padding()
                }
                .padding(.top, 60)
            }
            .ignoresSafeArea()
            .navigationBarItems(
                leading:
                    Button("note.cancel") {
                        self.dismiss()
                    }
                    .foregroundColor(.red),
                trailing:
                    Button(self.note == nil ? "note.add" : "note.save") {
                        
                        var success = false
                        if (self.note == nil) {
                            success = self.vm.insertNewNote(
                                title: self.title,
                                description: self.description,
                                includeDate: self.showDate,
                                date: self.date
                            )
                        } else {
                            self.note!.title = self.title
                            self.note!.descriptionText = self.description
                            self.note!.date = self.showDate ? self.date : nil
                            
                            success = self.vm.saveNote(note: self.note!)
                        }
                        
                        
                        if (success) {
                            self.dismiss()
                        }
                    }
            )
            .onAppear(perform: {
                if (self.note != nil) {
                    
                    self.title = self.note!.title ?? ""
                    self.description = self.note!.descriptionText ?? ""
                    self.date = self.note!.date ?? Date()
                    
                    if (self.note?.date != nil) {
                        self.showDate = true
                    }
                }
            })
            .navigationBarTitle(self.note == nil ? "note.new-note" : "note.edit-title", displayMode: .inline)
        }
        
    }
}



struct CustomTextEditor: View {
    let placeholder: String
    
    @Binding var text: String
    
    let internalPadding: CGFloat = 5
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            if text.isEmpty  {
                Text(placeholder)
                    .foregroundColor(Color.primary.opacity(0.25))
                    .padding(EdgeInsets(top: 7, leading: 4, bottom: 0, trailing: 0))
                    .padding(internalPadding)
            }
            
            TextEditor(text: $text)
                .padding(internalPadding)
        }.onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}
//
//struct AddNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNoteView()
//    }
//}


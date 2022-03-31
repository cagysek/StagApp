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
    
//    private let desctiptionPlaceholder = LocalizedStringKey("note.placeholder")
    
    var body: some View {
        NavigationView {
            
            
            ZStack {
                Color.defaultBackground
                
                ScrollView {
                    VStack {
                        VStack {
                        TextField("note.title", text: $title)
                                .frame(height: 30)
                                .padding(.leading, 7)
                                .padding(.top, 6)

                        Divider()
                            
                        TextEditor(text: self.$description)
                                .padding(.leading, 2)
                            .frame(height: 200)
                            .font(.system(size: 17, weight: .regular))
                            
//                            .foregroundColor(self.description == desctiptionPlaceholder ? .placeholderColor : .primary)
//                            .onTapGesture {
//                                if self.description == desctiptionPlaceholder {
//                                    self.description = ""
//                                }
//                            }
                        }
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .shadow, radius: 8)
                        
                        VStack {
                            Toggle("note.date", isOn: $showDate)
                                .padding(7)
                            
                            if (showDate) {
                                DatePicker("note.deadline", selection: $date, displayedComponents: [.date])
                                    .datePickerStyle(.graphical)
                                    .padding(7)
                                    
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
                    Button("note.add") {
                        let success = self.vm.insertNewNote(
                            title: self.title,
                            description: self.description,
                            includeDate: self.showDate,
                            date: self.date
                        )
                        
                        if (success) {
                            self.dismiss()
                        }
                    }
            )
            .navigationBarTitle("note.new-note", displayMode: .inline)
        }
        
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}

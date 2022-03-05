//
//  AddNoteView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 02.03.2022.
//

import SwiftUI

struct AddNoteView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var vm = NoteViewModel(noteRepository: NoteRepository(context: CoreDataManager.getContext()))
    
    @State private var title: String = ""
    @State private var description: String = "Poznámka"
    @State private var date: Date = Date()
    @State private var showDate: Bool = false
    
    private let desctiptionPlaceholder = "Poznámka"
    
    var body: some View {
        NavigationView {
            
            
            ZStack {
                Color.defaultBackground
                
                ScrollView {
                    VStack {
                        VStack {
                        TextField("Název", text: $title)
                                .frame(height: 30)
                                .padding(.leading, 7)
                                .padding(.top, 6)

                        Divider()
                            
                        TextEditor(text: self.$description)
                                .padding(.leading, 2)
                            .frame(height: 200)
                            .font(.system(size: 17, weight: .regular))
                            
                            .foregroundColor(self.description == desctiptionPlaceholder ? .placeholderColor : .primary)
                            .onTapGesture {
                                if self.description == desctiptionPlaceholder {
                                    self.description = ""
                                }
                            }
                        }
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .shadow, radius: 8)
                        
                        VStack {
                            Toggle("Datum", isOn: $showDate)
                                .padding(7)
                            
                            if (showDate) {
                                DatePicker("Deadline", selection: $date, displayedComponents: [.date])
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
                    Button("Zrušit") {
                        self.dismiss()
                    }
                    .foregroundColor(.red),
                trailing:
                    Button("Přidat") {
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
            .navigationBarTitle("Nová poznámka", displayMode: .inline)
        }
        
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}

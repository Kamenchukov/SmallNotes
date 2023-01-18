//
//  NoteViewModel.swift
//  SmallNotes
//
//  Created by Константин Каменчуков on 18.01.2023.
//

import Foundation

class NoteViewModel: ObservableObject {
    
    @Published var newText: String = ""
    @Published var editText: String
    @Published var note: Item?
    @Published var isNewNote: Bool
    @Published var titleNote: String
    
    private var coreDataManager = CoreDataManager.shared
    
    init(note: Item? = nil, isNewNote: Bool) {
        self.editText = note?.textContent ?? "Someting goes wrong"
        self.note = note
        self.isNewNote = isNewNote
        
        if note == nil {
            self.titleNote = ""
        } else {
            self.titleNote = note!.title!
        }
    }
    
    func addNote(viewModel: ContentViewModel) {
        if !newText.isEmpty {
            let newNote = Item(context: coreDataManager.viewContext)
            newNote.textContent = newText
            newNote.timestamp = Date()
            if titleNote == ""{
                titleNote = Date().toString
            }
            newNote.title = titleNote
            coreDataManager.save()
            viewModel.notes = coreDataManager.fetchData()
        }
    }
    
    func updateNote(viewModel: ContentViewModel) {
        if editText != note?.textContent || titleNote != note?.title {
            note?.textContent = editText
            note?.timestamp = Date()
            if titleNote == "" {
                titleNote = Date().toString
            }
            note?.title = titleNote
            coreDataManager.save()
            viewModel.notes = coreDataManager.fetchData()
        }
    }
    
    func changeButtonBackText() -> Bool {
        if editText == note?.textContent && titleNote == note?.title {
            return true
        } else {
            return false
        }
    }
}

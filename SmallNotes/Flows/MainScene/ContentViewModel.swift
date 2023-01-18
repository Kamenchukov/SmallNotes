//
//  ContentViewModel.swift
//  SmallNotes
//
//  Created by Константин Каменчуков on 18.01.2023.
//

import Foundation

class ContentViewModel: ObservableObject {
    private var coreDataManager = CoreDataManager.shared
    
    @Published var notes: [Item] = []
    @Published var isNewNote: Bool = false
    private var isFirstLaunchApp: Bool
    
    init() {
        isFirstLaunchApp = AppStarageManager.shared.loadFirstStatus()
        if isFirstLaunchApp {
            defaultListNotes()
            isFirstLaunchApp.toggle()
            AppStarageManager.shared.saveFirstStatus(isFirstLaunchApp: isFirstLaunchApp)
            coreDataManager.save()
        } else {
            updateData()
        }
    }
    
    func addNote() {
        isNewNote.toggle()
    }
    
    func updateData() {
        notes = coreDataManager.fetchData()
    }
    
    func deleteNote(note: Item) {
        coreDataManager.viewContext.delete(note)
        coreDataManager.save()
        updateData()
    }
    
    func defaultListNotes() {
        let defaultNote = Item(context: coreDataManager.viewContext)
        defaultNote.textContent = "👋 Hello user. This is an example of a note. Swipe left to delete a note."
        defaultNote.timestamp = Date()
        defaultNote.title = Date().toString
        notes = [defaultNote]
    }
}

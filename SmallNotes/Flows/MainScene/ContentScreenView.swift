//
//  ContentView.swift
//  SmallNotes
//
//  Created by Константин Каменчуков on 18.01.2023.
//

import SwiftUI
import CoreData

struct ContentScreenView: View {
    @EnvironmentObject var mainViewModel: ContentViewModel
    
    var body: some View {

        NavigationView {
            ZStack {
                VStack(spacing: 15) {
                    Text("List of Notes")
                        .font(.title.bold())
                        .foregroundColor(.blue)
                    notesScrollView
                    }
                    addNoteButton
                }
                .sheet(isPresented: $mainViewModel.isNewNote) {
                    NoteScreenView(viewModel: NoteViewModel(isNewNote: mainViewModel.isNewNote), editText: "")
                }
            }
        }
    }

extension ContentScreenView {
    private var addNoteButton: some View {
        Button(action: mainViewModel.addNote) {
            Image(systemName: "plus")
                .font(.system(size: 40))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .foregroundColor(.blue)
        .padding()
        .padding(.trailing, 20)
    }
    
    private var notesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                ForEach(mainViewModel.notes) { note in
                    NavigationLink {
                        NoteScreenView(viewModel: NoteViewModel(note: note, isNewNote: mainViewModel.isNewNote), editText: note.textContent ?? "")
                    } label: {
                        NoteCellView(note: note)
                            .swipeDeleteCustomModifier {
                                mainViewModel.deleteNote(note: note)
                            }
                        
                    }
                }
                .listRowBackground(Color.gray)
                
            }
            .padding(.top, 20)
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentScreenView().environmentObject(ContentViewModel())
    }
}


//
//  NoteScreenView.swift
//  SmallNotes
//
//  Created by Константин Каменчуков on 18.01.2023.
//

import SwiftUI

enum FocusField: Int, CaseIterable {
    case titleTextField
    case textEditor
}

struct NoteScreenView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var contentViewModel: ContentViewModel
    @StateObject var viewModel: NoteViewModel
    @State var editText: String
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        VStack {
            textTitleScene(viewModel.isNewNote)
            titleNoteTextField(text: $viewModel.titleNote, focusedField: $focusedField)
            
            TextEditor(text: viewModel.isNewNote ? $viewModel.newText : $viewModel.editText)
                .focused($focusedField, equals: .textEditor)
                .tint(Color.blue)
                .foregroundColor(Color.green)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                buttonBack
            }
            
            ToolbarItem(placement: .keyboard) {
                Button {
                    focusedField = nil
                } label: {
                    Text("Hide keyboard")
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            if editText.isEmpty {
                viewModel.addNote(viewModel: contentViewModel)
            } else {
                viewModel.updateNote(viewModel: contentViewModel)
            }
        }
    }
}
// MARK: - Extension
extension NoteScreenView {
    private var buttonBack: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "arrow.left")
                if viewModel.changeButtonBackText() {
                    Text("Back")
                } else {
                    Text("Save and Back")
                }
            }
        }
    }
    
    private var buttonCloseNewNote: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 30))
        }
    }
    
    @ViewBuilder private func textTitleScene(_ isNewNote: Bool) -> some View {
        let textNewNote = "Create New Note"
        let textEditNote = "Edit Note"
        
        HStack {
            Text(isNewNote ? textNewNote : textEditNote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title.bold())
                .padding(.leading, 24)
            if viewModel.isNewNote {
                buttonCloseNewNote
                    .foregroundColor(Color.blue)
            }
        }
    }
    
    private func titleNoteTextField(text: Binding<String>,
                                    focusedField: FocusState<FocusField?>.Binding)  -> some View  {
        TextField("Название заметки", text: text)
            .focused(focusedField, equals: .titleTextField)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .font(.title2.bold())
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(Color.white)
            .cornerRadius(10)
            .foregroundColor(Color.blue)
    }
}

struct NoteScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NoteScreenView(viewModel: NoteViewModel(isNewNote: true),
                              editText: "")
        .environmentObject(ContentViewModel())
    }
}



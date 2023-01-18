//
//  SmallNotesApp.swift
//  SmallNotes
//
//  Created by Константин Каменчуков on 18.01.2023.
//

import SwiftUI

@main
struct SmallNotesApp: App {
   @StateObject var viewModel = ContentViewModel()

    var body: some Scene {
        WindowGroup {
            ContentScreenView()
                .environmentObject(viewModel)
                .preferredColorScheme(.light)
        }
    }
}

//
//  NoteCellView.swift
//  SmallNotes
//
//  Created by Константин Каменчуков on 18.01.2023.
//

import SwiftUI

struct NoteCellView: View {
    
    @StateObject var note: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title ?? Date().toString)
                .font(.headline.bold())
                .foregroundColor(.blue)
            
            Text(note.textContent ?? "Empty")
                .font(.callout)
                .multilineTextAlignment(.leading)
                .foregroundColor(.blue)
            HStack {
                Spacer()
                Text(note.timestamp?.toString ?? Date().toString)
                    .font(.caption)
                    .padding(.trailing)
                    .foregroundColor(.blue)
            }
        }
        .padding(8)
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height / 6)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
    }
}

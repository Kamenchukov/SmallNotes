//
//  DateExtesion.swift
//  SmallNotes
//
//  Created by Константин Каменчуков on 18.01.2023.
//

import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy, HH:mm"
        return dateFormatter.string(from: self)
    }
}

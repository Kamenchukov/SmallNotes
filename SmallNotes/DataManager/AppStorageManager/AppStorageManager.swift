//
//  AppStorageManager.swift
//  SmallNotes
//
//  Created by Константин Каменчуков on 18.01.2023.
//

import SwiftUI

class AppStarageManager {
    static let shared = AppStarageManager()
    
    @AppStorage("isFirstLaunchApp") private var isFirstLaunchApp: Bool = true
    
    private init() {}
    
    func saveFirstStatus(isFirstLaunchApp: Bool) {
        self.isFirstLaunchApp = isFirstLaunchApp
    }
    
    func loadFirstStatus() -> Bool {
        isFirstLaunchApp
    }
}


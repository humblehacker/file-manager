//
//  FileManagerApp.swift
//  FileManager
//
//  Created by David Whetstone on 12/23/22.
//

import SwiftUI

@main
struct FileManagerApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TerminalManager())
        }
    }
}

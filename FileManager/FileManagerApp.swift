//
//  FileManagerApp.swift
//  FileManager
//
//  Created by David Whetstone on 12/23/22.
//

import SwiftUI

@main
struct FileManagerApp: App {
    @EnvironmentObject var terminalManager: TerminalManager
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TerminalManager())
        }
    }
}

//
//  FileManagerApp.swift
//  FileManager
//
//  Created by David Whetstone on 12/23/22.
//

import AppFeature
import ComposableArchitecture
import SwiftUI
import TerminalFeature

@main
struct FileManagerApp: App {
    let store: StoreOf<AppFeature> = Store(initialState: AppFeature.State(), reducer: AppFeature())

    init() {}

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
                .environmentObject(TerminalManager())
        }
    }
}

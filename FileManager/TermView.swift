//
//  TermView.swift
//  FileManager
//
//  Created by David Whetstone on 12/23/22.
//

import SwiftUI
import SwiftTerm

struct TermView: NSViewRepresentable {
    @EnvironmentObject var terminalManager: TerminalManager

    func makeNSView(context: Context) -> SwiftTerm.TerminalView {
        terminalManager.terminal
    }

    func updateNSView(_ nsView: SwiftTerm.TerminalView, context: Context) {
    }
}

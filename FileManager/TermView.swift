//
//  TermView.swift
//  FileManager
//
//  Created by David Whetstone on 12/23/22.
//

import SwiftUI
import SwiftTerm

struct TermView: NSViewRepresentable {
    var initialUpdate = false

    func makeNSView(context: Context) -> SwiftTerm.TerminalView {
        let term = LocalProcessTerminalView(frame: .zero)

        let env = ProcessInfo.processInfo.environment
        let shell = env["SHELL"] ?? "/bin/zsh"

        FileManager.default.changeCurrentDirectoryPath(FileManager.default.homeDirectoryForCurrentUser.path)

        let vars = Terminal.getEnvironmentVariables(termName: "xterm-color", trueColor: false, additionalVarsToCopy: ["SHELL"]).toVars()
        term.startProcess(executable: "\(shell)", args: [], environment: vars, execName: "-\(shell)")
        return term
    }

    func updateNSView(_ nsView: SwiftTerm.TerminalView, context: Context) {
    }
}

extension Terminal {
    public static func getEnvironmentVariables(termName: String? = nil, trueColor: Bool = true, additionalVarsToCopy: [String] = []) -> [String: String] {
        let localEnv: [String: String] = [
            "TERM": "\(termName ?? "xterm-256color")",
            "COLORTERM": trueColor ? "truecolor" : "",
            "LANG": "en_US.UTF-8" // Without this, tools like "vi" produce sequences that are not UTF-8 friendly
        ]

        let varsToCopy = ["LOGNAME", "USER", "DISPLAY", "LC_TYPE", "USER", "HOME"] + additionalVarsToCopy
        return ProcessInfo.processInfo.environment
            .filter { varsToCopy.contains($0.key) }
            .merging(localEnv, uniquingKeysWith: { l, r in l })
    }
}

extension Dictionary where Key == String, Value == String {
    func toVars() -> [String] {
        map { key, value in "\(key)=\(value)" }
    }
}

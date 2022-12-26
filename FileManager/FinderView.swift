//
//  FinderView.swift
//  FileManager
//
//  Created by David Whetstone on 12/24/22.
//

import SwiftUI

struct FinderView: View {
    @EnvironmentObject var terminalManager: TerminalManager
    var body: some View {
        Text(terminalManager.currentDirectory.path)
            .background(Color.orange)
    }
}

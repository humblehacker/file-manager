//
//  ContentView.swift
//  FileManager
//
//  Created by David Whetstone on 12/23/22.
//

import SwiftUI

enum Position {
    case left
    case right
    case top
    case bottom
}

struct ContentView: View {
    @State var primaryPosition: Position = .top
    @EnvironmentObject var terminalManager: TerminalManager
    var body: some View {
        SplitView(primaryPosition: primaryPosition,
            primaryContent: {
                FinderView()
            },
            secondaryContent: {
                TermView()
                    .padding(4)
                    .background(Color.black)
            }
        )
        .toolbar {
            ToolbarItemGroup {
                Picker("", selection: $primaryPosition) {
                    Image(systemName: "square.righthalf.filled")
                        .tag(Position.left)
                    Image(systemName: "square.lefthalf.filled")
                        .tag(Position.right)
                    Image(systemName: "square.bottomhalf.filled")
                        .tag(Position.top)
                    Image(systemName: "square.tophalf.filled")
                        .tag(Position.bottom)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

struct SplitView<Content1, Content2>: View where Content1: View, Content2: View {
    let primaryPosition: Position
    let primaryContent: Content1
    let secondaryContent: Content2

    init(primaryPosition: Position = .top,
         @ViewBuilder primaryContent: () -> Content1,
         @ViewBuilder secondaryContent: () -> Content2
    ) {
        self.primaryPosition = primaryPosition
        self.primaryContent = primaryContent()
        self.secondaryContent = secondaryContent()
    }

    var body: some View {
        GeometryReader { geo in
            if (primaryPosition == .top) {
                VSplitView {
                    primaryContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    secondaryContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            } else if primaryPosition == .bottom {
                VSplitView {
                    secondaryContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    primaryContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            } else if primaryPosition == .left {
                HSplitView {
                    primaryContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    secondaryContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            } else if primaryPosition == .right {
                HSplitView {
                    secondaryContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    primaryContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}

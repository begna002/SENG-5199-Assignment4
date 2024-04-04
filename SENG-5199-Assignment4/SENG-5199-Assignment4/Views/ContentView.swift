//
//  ContentView.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 3/29/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: Tab = .madLibs

    enum Tab {
        case madLibs
        case completed
    }

    var body: some View {
        TabView(selection: $selection) {
            MadLibView()
                .tabItem {
                    Label("MadLibs", systemImage: "square.and.pencil")
                }
                .tag(Tab.madLibs)

            CompletedView()
                .tabItem {
                    Label("Completed", systemImage: "checklist.checked.rtl")
                }
                .tag(Tab.completed)
        }
    }
}

#Preview {
    ContentView()
}

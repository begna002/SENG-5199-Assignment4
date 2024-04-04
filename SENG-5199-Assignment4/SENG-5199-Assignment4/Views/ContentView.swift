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
    @StateObject var account = Account.shared

    enum Tab {
        case madLibs
        case completed
        case account
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
            
            AccountView()
                .tabItem {
                    Label(account.userName, systemImage: "person.crop.circle.fill")
                }
                .tag(Tab.account)
        }
    }
}

#Preview {
    ContentView()
}

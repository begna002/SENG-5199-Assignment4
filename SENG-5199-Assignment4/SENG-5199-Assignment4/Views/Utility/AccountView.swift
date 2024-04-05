//
//  AccountView.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 4/3/24.
//

import Foundation
import SwiftUI

class Account: ObservableObject {
    static let shared = Account()

    @Published var userName: String = "begna002"
    
}


struct AccountView: View {
    @StateObject var account = Account.shared
    @State var userName: String = ""
    
    var body: some View {
        ZStack {
            Form {
                Section() {
                    TextField("Enter", text: $userName)
                        .autocapitalization(.none)
                } header: {
                    Text("Username")
                } footer: {
                    VStack(alignment: .center) {
                        Spacer()
                        Button("Submit") {
                            account.userName = userName
                            userName = ""
                        }.disabled(userName == "")
                    }
                }
                Section() {
                    VStack {
                        Text("Current Username: \(account.userName)")
                    }
                }
            }
        }
        .navigationTitle("Account")
        .environmentObject(account)
    }

}



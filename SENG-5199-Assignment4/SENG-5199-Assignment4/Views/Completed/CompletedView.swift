//
//  CompletedView.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 3/29/24.
//

import Foundation
import SwiftUI

struct CompletedView: View {
    @State var madLibAnswerResponseList: [MadLibAnswerResponse]?
    @State var isError: Bool = false
    @StateObject var account = Account.shared

    var body: some View {
        VStack(alignment: .leading) {
            if let madLibAnswerResponseList {
                NavigationSplitView {
                    List {
                        ForEach(madLibAnswerResponseList, id:\.self) { madLibAnswer in
                            NavigationLink {
                                CompletedAnswerView(id: madLibAnswer.filledOutMadLibId,
                                                    title: madLibAnswer.storyTitle)
                            } label: {
                                VStack(alignment: .leading, content: {
                                    Text(madLibAnswer.storyTitle)
                                    Text("Date: \(dateFormatter(dateString: madLibAnswer.timestamp))")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)

                                })
                            }
                        }
                    }
                    .navigationTitle("Completed MadLibs")
                } detail: {
                    Text("Completed Madlibs")
                }
            } else if isError {
                NavigationSplitView {
                    VStack {
                        Text("Error with username '\(account.userName)'")
                    }
                } detail: {
                    Text("Completed Madlibs")
                }
                
            } else {
                LoadingIndicator()
            }
        }
        .refreshable {
            fetchCompletedList()
        }
        .task {
            guard madLibAnswerResponseList != nil else {
                fetchCompletedList()
                return
            }
        }
    }
    
    func dateFormatter(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        
        if var d = date {
            d.addTimeInterval(TimeInterval(-18000))
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: d)
            
        } else {
            return ""
        }
    }
    
    func fetchCompletedList() {
        getAllAnswers(userName: account.userName, completion: {msg in
            if let message = msg {
                madLibAnswerResponseList = message
                isError = false
            } else {
                madLibAnswerResponseList = nil
                isError = true
            }
            
        })
    }
}

#Preview {
    CompletedView()
}

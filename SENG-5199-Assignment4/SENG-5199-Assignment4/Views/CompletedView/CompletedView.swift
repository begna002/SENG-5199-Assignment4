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
                                    Text(madLibAnswer.timestamp)
                                })
                            }
                        }
                    }
                    .navigationTitle("Completed MadLibs")
                } detail: {
                    Text("Completed Madlibs")
                }
            } else {
                LoadingIndicator()
            }
        }
        .task {
            getAllAnswers(completion: {msg in
                madLibAnswerResponseList = msg
            })
        }
    }
}

#Preview {
    CompletedView()
}

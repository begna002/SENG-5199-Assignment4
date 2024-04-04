//
//  CompletedAnswerView.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 3/29/24.
//

import Foundation
import SwiftUI

struct CompletedAnswerView: View {
    let id: Int
    let title: String
    @State var answer: String?

    var body: some View {
        VStack {
            if let answer {
                Form {
                    Section() {
                        Text(answer)
                    }
                }
                .navigationTitle(title)
            }
        }
        .task {
            guard answer != nil else {
                getAnswer(id: id, completion: {msg in
                    answer = msg
                })
                return
            }
        }
    }
}

#Preview {
    CompletedAnswerView(id: 16, title: "Madlib Answer")
}

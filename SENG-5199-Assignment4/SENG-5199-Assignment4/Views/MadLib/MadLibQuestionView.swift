//
//  MadLibView.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 3/29/24.
//

import Foundation
import SwiftUI


struct MadLibQuestionView: View {
    let id: Int
    @State var madLib: MadLib?
    @State var answerList: [String] = []
    @State var canSubmit: Bool = false
    @State var responseString: String?
    @State var fetching: Bool = false
    @StateObject var account = Account.shared

    var body: some View {
        ZStack {
            Form {
                Section() {
                    if let madLib, !answerList.isEmpty {
                        List {
                            ForEach(madLib.questions) { question in
                                HStack {
                                    Text("\(question.description):").bold()
                                    TextField("Enter", text: $answerList[question.position])
                                        .disabled(responseString != nil)
                                        .autocapitalization(.none)
                                }
                            }
                        }
                        .navigationBarTitle(madLib.storyTitle)
                    }
                } header: {
                    Text("Give me a...")
                } footer: {
                    VStack(alignment: .center) {
                        Spacer()
                        Button("Submit") {
                            Task {
                                fetching = true
                                await submitForm()
                            }
                        }.disabled(!checkSubmitEnabled())
                    }
                }
                
                if let responseString {
                    Section() {
                        Text(responseString)
                        
                    } header: {
                        HStack(alignment: .center) {
                            Text("Answer:")
                        }
                    } footer: {
                        VStack {
                            Spacer()
                            Button("Reset") {
                                resetForm()
                            }
                        }
                    }
                }
            }
            
            if (fetching) {
                LoadingIndicator()
            }
        }
        .task {
            guard madLib != nil else {
                getMadLib(id: id, completion: {msg in
                    madLib = msg
                    if let madLib {
                        answerList = [String](repeating: "", count: madLib.questions.count)
                    }
                })
                return
            }
        }
    }
    
    func checkSubmitEnabled() -> Bool {
        if (responseString != nil) {
            return false
        }
        
        for answer in answerList {
            if answer == "" {
                return false
            }
        }
        return true
    }
    
    func resetForm() {
        if let madLib {
            answerList = [String](repeating: "", count: madLib.questions.count)
            canSubmit = false
            responseString = nil
            fetching = false
        }
    }
    
    func submitForm() async {
        if let madLib {
            let answerForm = madLib.createAnswerForm(answerList: answerList, username: account.userName)
            postAnswer(body: answerForm, completion: {msg in
                responseString = msg
                fetching = false
            })
        }
    }
}

#Preview {
    MadLibQuestionView(id: 1)
}

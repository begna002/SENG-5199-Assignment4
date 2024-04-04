//
//  MadLib.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 3/29/24.
//

import Foundation

struct MadLib: Codable {
    let id: Int
    let storyTitle: String
    let story: String
    let questions: [Questions]
    
    func createAnswerForm(answerList: [String]) -> FilledOutMadLib {
        var answers: [Answer] = []
        for question in questions {
            answers.append(Answer(questionId: question.id, answerValue: answerList[question.position]))
        }
        let date = Date()
        let localISOFormatter = ISO8601DateFormatter()
        
        let dateString = localISOFormatter.string(from: date)
        
        return FilledOutMadLib(madLibId: self.id, timestamp: dateString, answers: answers)
    }
}

struct Questions: Codable, Identifiable {
    let id: Int
    let position: Int
    let description: String
}

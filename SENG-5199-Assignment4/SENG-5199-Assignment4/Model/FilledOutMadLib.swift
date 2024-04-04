//
//  FilledOutMadLib.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 3/29/24.
//

import Foundation

struct FilledOutMadLib: Codable {
    let madLibId: Int
    var username: String = "begna002TEST2"
    var timestamp: String 
    var answers: [Answer]
}

struct Answer: Codable {
    var questionId: Int
    var answerValue: String
}

//
//  MadLibAnswerResponse.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 3/29/24.
//

import Foundation

struct MadLibAnswerResponse: Codable, Hashable {
    let filledOutMadLibId: Int
    let madLibId: Int
    let storyTitle: String
    let timestamp: String
}

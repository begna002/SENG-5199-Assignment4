//
//  MadLibService.swift
//  SENG-5199-Assignment4
//
//  Created by Moti Begna on 3/29/24.
//

import Foundation

let baseUrl = "https://seng5199madlib.azurewebsites.net"

func getMadLib(id: Int, completion: @escaping (MadLib?) -> Void){
    let url = URL(string: "\(baseUrl)/api/MadLib/\(id)" )!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error fetching all mad libs: \(error)")
            completion(nil)
            return
        }

        guard let responseData = data else {
          completion(nil)
          return
        }
        
        do {
          let madlib = try JSONDecoder().decode(MadLib.self, from: responseData)
            completion(madlib)

        } catch {
          print("Error decoding JSON data: \(error)")
        }
    }
    task.resume()
}

func getAllMadLibs(completion: @escaping ([MadLibResponse]?) -> Void){
    let url = URL(string: "\(baseUrl)/api/MadLib" )!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error fetching all mad libs: \(error)")
            completion(nil)
            return
        }

        guard let responseData = data else {
          completion(nil)
          return
        }
        
        do {
            let madlib = try JSONDecoder().decode([MadLibResponse].self, from: responseData)
            completion(madlib)

        } catch {
          print("Error decoding JSON data: \(error)")
        }
    }
    task.resume()

}

func getAnswer(id: Int, completion: @escaping (String?) -> Void){
    let url = URL(string: "\(baseUrl)/api/PostMadLib/\(id)" )!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error fetching mad lib solution with id \(id): \(error)")
            completion(nil)
            return
        }

        guard let responseData = data else {
          completion(nil)
          return
        }
        
        let responseString = String(data: responseData, encoding: .utf8)
        completion(responseString)
    }
    task.resume()
}

func getAllAnswers(userName: String, completion: @escaping ([MadLibAnswerResponse]?) -> Void){
    if (userName == "") {
        completion(nil)
        return
    }
    
    let url = URL(string: "\(baseUrl)/api/PostMadLib?username=\(userName)" )!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error fetching all mad lib solutions: \(error)")
            completion(nil)
            return
        }

        guard let responseData = data else {
          completion(nil)
          return
        }
        
        do {
            let madlib = try JSONDecoder().decode([MadLibAnswerResponse].self, from: responseData)
            completion(madlib)
        } catch {
          print("Error decoding JSON data: \(error)")
        }
    }
    task.resume()
}

func postAnswer(body: FilledOutMadLib, completion: @escaping (String?) -> Void){
    let url = URL(string: "\(baseUrl)/api/PostMadLib" )!
    let data = try! JSONEncoder().encode(body)

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error fetching posting mad lib: \(error)")
            return
        }

        guard let responseData = data else {
          return
        }
        
        let responseString = String(data: responseData, encoding: .utf8)
        completion(responseString)
        
    }
    
    task.resume()
}

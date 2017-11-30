//
//  QuestionManager.swift
//  OpenQuizz
//
//  Created by Christophe Bugnon on 27/11/2017.
//  Copyright © 2017 Christophe Bugnon. All rights reserved.
//


import UIKit

class QuestionManager {
    private let url = URL(string: "https://opentdb.com/api.php?amount=10&type=boolean")!
    
    // Créé une instance de QuestionManager (pattern singleton)
    static let shared = QuestionManager()
    private init() {}
    
    // Recois les questions via l'API avec une closure
    func get(completionHandler: @escaping ([Question]) -> Void) {
        let task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            guard error == nil else {
                completionHandler([Question]())
                return
            }
            DispatchQueue.main.async {
                completionHandler(self.parse(data: data))
            }
        }
        task.resume()
    }
    
    private func parse(data: Data?) -> [Question] {
        guard let data = data,
            let serializedJson = try? JSONSerialization.jsonObject(with: data, options: []),
            let parsedJson = serializedJson as? [String: Any],
            let results = parsedJson["results"] as? [[String: Any]] else {
                return [Question]()
        }
        return getQuestionsFrom(parsedDatas: results)
    }
    
    private func getQuestionsFrom(parsedDatas: [[String: Any]]) -> [Question]{
        var retrievedQuestions = [Question]()
        
        for parsedData in parsedDatas {
            retrievedQuestions.append(getQuestionFrom(parsedData: parsedData))
        }
        
        return retrievedQuestions
    }
    
    private func getQuestionFrom(parsedData: [String: Any]) -> Question {
        if let title = parsedData["question"] as? String,
            let answer = parsedData["correct_answer"] as? String {
            return Question(title: String(htmlEncodedString: title)!, isCorrect: (answer == "True"))
        }
        return Question()
    }
}


extension String {
    
    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
    }
    
}

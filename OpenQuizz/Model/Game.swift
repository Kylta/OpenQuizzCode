//
//  Game.swift
//  OpenQuizz
//
//  Created by Christophe Bugnon on 27/11/2017.
//  Copyright © 2017 Christophe Bugnon. All rights reserved.
//

import Foundation

class Game {
    // Score du joueur
    var score = 0
    // Tableau de questions
    private var questions = [Question]()
    // Le numéro que la question actuelle
    private var currentIndex = 0
    // L'état de la partie
    var state: State = .ongoing
    // Enum pour vérifier l'état de la partie
    enum State {
        case ongoing, over
    }
    // Pour afficher une seule question par rapport à l'index
    var currentQuestion: Question {
        return questions[currentIndex]
    }
    // Refresh la partie pour charger la question. Si les question ne sont pas chargé (score = 0, currentIndex = 0, state = .over). Si les questions sont chargées la partie commence et l'état est donc à .ongoing
    func refresh() {
        score = 0
        currentIndex = 0
        state = .over
        
        // Retourne les questions télécharger via l'API dans la class QuestionManager
        QuestionManager.shared.get { (questions) in
            self.questions = questions
            self.state = .ongoing
            let nameNotification = Notification.Name(rawValue: "QuestionsLoadled")
            let notification = Notification(name: nameNotification)
            NotificationCenter.default.post(notification)
        }
    }
    /* Remplacé par une close dans refresh QuestionManager
     // Methode pour recevoir les questions
     private func receiveQuestion(_ questions: [Question]) {
     self.questions = questions
     print(questions)
     state = .ongoing
     }*/
    
    // Gérer le score du joueurs en fonction de sa réponse et afficher la question suivante
    func answerCurrentQuestion(with answer: Bool) {
        if (currentQuestion.isCorrect && answer) || (!currentQuestion.isCorrect && !answer) {
            score += 1
        }
        goToNextQuestion()
    }
    
    // Afficher la prochaine question
    private func goToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        } else {
            // Arrete la partie lorsqu'il n'y a plus de questions
            finishGame()
        }
    }
    // Arrete la partie
    private func finishGame() {
        state = .over
    }
}

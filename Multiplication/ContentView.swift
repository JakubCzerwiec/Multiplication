//
//  ContentView.swift
//  Multiplication
//
//  Created by Mój Maczek on 08/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    struct Question {
        let textOfQ: String
        let answer: Int
    }
    
    @State private var gameStarted = false
    @State private var gameRange = 2
    @State private var questionsAmount = 5
    @State private var questions = [Multiplication.ContentView.Question(textOfQ: "How much is 1 * 1", answer: 1)]
    @State private var questionNumber = 0
    @State private var answer = Int()
    @State private var score = 0
    @State private var startButtonActive = false
    @State private var bum = ""
    @State var name = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Enter your name below:")
                TextField("name...", text: $bum)
                NavigationLink(destination: GameView(questions: questions)) {
                    Text("Start Game")
                }.simultaneousGesture(TapGesture().onEnded{startGame()})
                
                
                VStack {
                    Stepper("What range you want to practice?", value: $gameRange, in: 2...12)
                    Text("\(gameRange)")
                    Stepper("How many questions?", value: $questionsAmount, in: 5...20, step: 5)
                    Text("\(questionsAmount)")

                    TextField("Answer", value: $answer, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Section{
                        if questions.count > 1 {
                            Text(questions[questionNumber].textOfQ)
                        }
                    }
                }
            }
        }
        .padding()
    }

    func startGame() {
        for _ in 0..<questionsAmount {
            pushEm()
        }
        score = 0
    }
    
    func pushEm() {
        let firstM = Int.random(in: 1...gameRange)
        let secondM = Int.random(in: 1...gameRange)
        let q = Question(textOfQ: "How much is \(firstM) * \(secondM)", answer: firstM * secondM)
            questions.insert(q, at: 0)
        print(questions)
    }
    
    func submit() {
        if answer == questions[questionNumber].answer {
            score += 1
        }
        answer = 0
        print(answer)
        print("Score = \(score)")
        questionNumber += 1
    }
    
    func endGame () {
        // wywołać alerta z końcowym wynikiem i powrotem do poprzedniego widoku
    }
}

#Preview {
    ContentView()
}

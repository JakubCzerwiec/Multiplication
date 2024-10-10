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
    
    @State private var gameRange = 2
    @State private var questionsAmount = 5
    @State private var questions = [Multiplication.ContentView.Question(textOfQ: "How much is 1 * 1", answer: 1)]
    @State private var questionNumber = 0
    @State private var answer = Int()
    @State private var score = 0
    @State var name = ""
    @FocusState private var isFocused: Bool
    @State private var navActive = true
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Text("Enter your name below:")
                    TextField("name...", text: $name)
                        .onSubmit {
                            validateName()
                        }
                    Stepper("What range you want to practice?", value: $gameRange, in: 2...12)
                    Text("\(gameRange)")
                    Stepper("How many questions?", value: $questionsAmount, in: 5...20, step: 5)
                    Text("\(questionsAmount)")
                }
                .frame(height: 340)
                Section {
                    NavigationLink(destination: GameView(name: name, questions: questions)) {
                        Text("Start Game")
                            .frame(width: 200, height: 50)
                            .background(LinearGradient(colors: [.green, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipped()
                            .clipShape(.rect(cornerRadius: 20))
                    }.simultaneousGesture(TapGesture().onEnded{startGame()})
                     .disabled(navActive)
                }
                
                Spacer()
                .alert(errorTitle, isPresented: $showingError) {
                    Button("OK") {}
                } message: {
                    Text(errorMessage)
                }
                .onAppear {
                    gameRange = 2
                    questionsAmount = 5
                    score = 0
                    name = ""
                    questions.removeAll()
                    navActive = true
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
            .scrollContentBackground(.hidden)
        }
    }
        
    func validateName() {
        let myname = name
        guard nameLongEnough(word: myname) else {
            nameError(title: "Plese, enter your name", message: "Or at least initials")
            return
        }
    }
    func startGame() {
        for _ in 0..<questionsAmount + 1 {
            pushEm()
        }
    }
    
    func pushEm() {
        let firstM = Int.random(in: 1...gameRange)
        let secondM = Int.random(in: 1...gameRange)
        let q = Question(textOfQ: "How much is \(firstM) * \(secondM)?", answer: firstM * secondM)
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
    
    func nameError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true

    }
    
    func nameLongEnough(word: String) -> Bool {
        if word.count == 0 {
            return false
        }
        navActive = false
        return true
    }
}

#Preview {
    ContentView()
}

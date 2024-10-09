//
//  GameView.swift
//  Multiplication
//
//  Created by Mój Maczek on 08/10/2024.
//

import SwiftUI

struct GameView: View {
    
    var bum: String!
    @State private var score = 0
    
    @State private var questionNumber = 0
    @State private var answer = Int()
    @FocusState private var amountIsFocused: Bool
    
    @State private var endingGame = false
    
    @State private var scoreTitle = ""
    
    var questions = [Multiplication.ContentView.Question(textOfQ: "TEEEEEST", answer: 1)]
    
    var body: some View {

        Section{
            if questions.count > 0 {
                Text(questions[questionNumber].textOfQ)
            }
        }
        Form {
            Section {
                TextField("Answer", value: $answer, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused) // to nie działa!!!!!!
            }
        }



        Button("Submit") {
            submit()
            answer = 0
            isOver()
            // dodać warunek zakończenia gry
        }
        
        .alert(scoreTitle, isPresented: $endingGame) {
            Button("yup", action: endGame)
        } message: {
            Text("Final score is: \(score)")
        }
        
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
    
    func isOver() {
        if questionNumber+1 == questions.count {
            endingGame = true
        }
    }
    
    func endGame() {
        // powrót do pierwszego ekranu i zerowanie ustawien
    }
 
}

#Preview {
    GameView()
}

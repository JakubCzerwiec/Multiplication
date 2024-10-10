//
//  GameView.swift
//  Multiplication
//
//  Created by Mój Maczek on 08/10/2024.
//

import SwiftUI

struct GameView: View {
    // This line is required for custom navigation bar and PLAY AGAIN button
    // Return to previous view with other button then system 'back'
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var score = 0
    
    @State private var questionNumber = 0
    @State private var answer = Int()
    var prompts = ["What about this one,", "Try this one,", "This one should be easy,", "Another chellange for you,", "Tackle that,"]
    @State var promptNum = 0
    @FocusState private var amountIsFocused: Bool
    
    @State private var endingGame = false
    @State private var gameEnded = false
    @State private var gameNotEnded = true
    @State private var scoreTitle = ""
    var name = ""
    
    var questions = [Multiplication.ContentView.Question(textOfQ: "TEEEEEST", answer: 1)]
    
    var body: some View {
        VStack {
            VStack {
                if gameNotEnded {
                    VStack {
                        Form {
                            Section{
                                if questions.count > 0 {
                                    Text("\(prompts[promptNum]) \(name):")
                                    Text(questions[questionNumber].textOfQ)
                                }
                            }
                            TextField("Answer", value: $answer, format: .number)
                                .keyboardType(.numberPad)
                                .focused($amountIsFocused)
                        }
                        .frame(height: 280)
                        Section {
                            Button("Submit") {
                                submit()
                                answer = Int()
                                isOver()
                            }
                            .frame(width: 150, height: 50)
                            .background(.blue)
                            .font(.title)
                            .foregroundColor(.white)
                            .clipped()
                            .clipShape(.rect(cornerRadius: 20))
                            .padding()
                        }
                        Spacer()
                    }
                    .toolbar {
                        if amountIsFocused {
                            Button("Done") {
                                amountIsFocused = false
                            }
                        }
                    }
                }
                if gameEnded {
                    Button("Play Again") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: 200, height: 50)
                    .background(LinearGradient(colors: [.green, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipped()
                    .clipShape(.rect(cornerRadius: 20))

                }
            }
            .alert(scoreTitle, isPresented: $endingGame) {
                Button("Got it!") {}
            } message: {
                Text("\(name), Your final score is: \(score)")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .init(horizontal: .center, vertical: .center))
        // this two below changes background for the Form
        .background(LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
        .scrollContentBackground(.hidden)
    }
    
    func submit() {
        if answer == questions[questionNumber].answer {
            score += 1
        }
        answer = 0
        print(answer)
        print("Score = \(score)")
        questionNumber += 1
        promptNum = .random(in: 0..<prompts.count)
    }
    
    func isOver() {
        if questionNumber+1 == questions.count {
            endingGame.toggle()
            gameNotEnded.toggle()
            gameEnded.toggle()
        }
    }
}

#Preview {
    GameView()
}

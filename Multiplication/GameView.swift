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
    @FocusState private var amountIsFocused: Bool
    
    @State private var endingGame = false
    @State private var gameEnded = false
    @State private var gameNotEnded = true
    @State private var scoreTitle = ""
    var name = ""
    
    var questions = [Multiplication.ContentView.Question(textOfQ: "TEEEEEST", answer: 1)]
    
    var body: some View {
        Text("")
        // Custom back button
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem (placement: .navigationBarLeading)  {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.left.2.fill")
                            .foregroundColor(.blue)
                    })
                }
            })
        // Custom back button
        ZStack {
            LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            NavigationView {
                VStack{
                    if gameNotEnded {
                        Section{
                            Text("\(prompts[.random(in: 0..<prompts.count)]) \(name):")
                            if questions.count > 0 {
                                Text(questions[questionNumber].textOfQ)
                            }
                        }
                        Form {
                            Section {
                                TextField("Answer", value: $answer, format: .number)
                                    .keyboardType(.numberPad)
                                    .focused($amountIsFocused)
                            }
                        }
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        
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
                        .toolbar {
                            if amountIsFocused {
                                Button("Done") {
                                    amountIsFocused = false
                                }
                            }
                        }
                    }
                    VStack {
                        if gameEnded {
                            Button("Play Again") {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }

                .alert(scoreTitle, isPresented: $endingGame) {
                    Button("Got it!") {}
                } message: {
                    Text("\(name), Your final score is: \(score)")
                }
            }
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
            endingGame.toggle()
            gameNotEnded.toggle()
            gameEnded.toggle()
        }
    }
}

#Preview {
    GameView()
}

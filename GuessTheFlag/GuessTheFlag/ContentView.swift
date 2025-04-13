//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nick Dimitrakopoulos on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    @State private var correctCountry = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var totalQuestions = 0
    
    @State private var alertTitle = ""
    @State private var isFlagTapped = false
    
    @State private var tappedCountry = 0
    @State private var gameOver = false
        
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200.0, endRadius: 700.0)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 20.0) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctCountry])
                            .font(.largeTitle.weight(.semibold))
                        
                        ForEach(0..<3) { number in
                            Button {
                                isCountryCorrect(number)
                            } label: {
                                Image(countries[number])
                                    .clipShape(.capsule)
                                    .shadow(radius: 5.0)
                            }
                        }
                    }

                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20.0)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20.0))
                
                Spacer()
                Spacer()
                
                Text("Score is \(score) / \(totalQuestions)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
            
            
        }
        
        .alert(alertTitle, isPresented: $isFlagTapped) {
            Button("Next question") {
                askQuestion()
            }
        } message: {
            if alertTitle == "Corrent!" {
                Text("Your score is \(score) / \(totalQuestions)")
            } else {
                Text("That's the flag of \(countries[tappedCountry])")
            }
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("Start new game") {
                askQuestion()
                score = 0
                totalQuestions = 0
            }
        } message: {
            if alertTitle == "Corrent!" {
                Text("Corrent!\n\nYour final score is \(score) / \(totalQuestions)")
            } else {
                Text("Wrong! That's the flag of \(countries[tappedCountry])\n\nYou final score is \(score) / \(totalQuestions)")
            }
        }
    }
    
    func isCountryCorrect(_ index: Int) {
        if index == correctCountry {
            alertTitle = "Corrent!"
            score += 1
        } else {
            tappedCountry = index
            alertTitle = "Wrong!"
        }
        totalQuestions += 1
        if totalQuestions == 8 {
            gameOver = true
        } else {
            isFlagTapped = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctCountry = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}

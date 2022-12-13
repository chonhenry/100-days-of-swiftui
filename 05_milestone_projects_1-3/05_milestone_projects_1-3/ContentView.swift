//
//  ContentView.swift
//  05_milestone_projects_1-3
//
//  Created by Henry Chon on 12/12/22.
//

import SwiftUI

enum Gesture: String {
    case rock = "✊"
    case paper = "🖐"
    case scissors = "✌️"
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var gameLeft = 10
    @State private var score = 0
    @State private var win = Bool.random()
    @State private var move: Gesture
    
    let moves:[Gesture] = [Gesture.rock, Gesture.paper, Gesture.scissors]
    
    init() {
        move = moves.randomElement()!
    }
    
    var type:String {
        return win ? "win" : "lose"
    }
    
    func pressMove(_ s: Gesture) {
        if win {
            score += toWin(s)
        } else {
            score  += toLose(s)
        }
        move = moves.randomElement()!
        win = Bool.random()
        gameLeft -= 1
        
        if gameLeft == 0 {
            showingScore = true
        }
    }
    
    func resetGame() {
        gameLeft = 10
        score = 0
    }
    
    func toWin(_ moveChosen: Gesture) -> Int {
        var addPoint: Bool
        if moveChosen == Gesture.rock {
            addPoint = self.move == Gesture.scissors
        } else if moveChosen == Gesture.paper {
            addPoint =  self.move == Gesture.rock
        } else {
            addPoint = self.move == Gesture.paper
        }
        
        return addPoint ? 1 : 0
    }
    
    func toLose(_ moveChosen: Gesture) -> Int {
        var addPoint: Bool
        
        if moveChosen == Gesture.rock {
            addPoint = self.move == Gesture.paper
        } else if moveChosen == Gesture.paper {
            addPoint = self.move == Gesture.scissors
        } else {
            addPoint = self.move == Gesture.rock
        }
        
        return addPoint ? 1 : 0
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Text("\(move.rawValue)")
                .font(.system(size: 150))
            
            Text("How to \(type) this game?")
                .font(.title)
            
            HStack {
                Button {
                    pressMove(Gesture.rock)
                } label: {
                    Text("\(Gesture.rock.rawValue)").font(.system(size: 50))
                }
                
                Button {
                    pressMove(Gesture.paper)
                } label: {
                    Text("\(Gesture.paper.rawValue)").font(.system(size: 50))
                }
                
                Button {
                    pressMove(Gesture.scissors)
                } label: {
                    Text("\(Gesture.scissors.rawValue)").font(.system(size: 50))
                }
            }
            
            Text("Game left: \(gameLeft)").font(.title)
            Text("Your score: \(score)").font(.title)
        }
        .alert("Your score is \(score)", isPresented: $showingScore) {
            Button("Continue", action: resetGame)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

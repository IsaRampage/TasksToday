//
//  TicTacToeGame.swift
//  TasksToday
//
//  Created by Isa Rampage on 07.06.23.
//

import Foundation

class TicTacToeGame: ObservableObject {
    @Published var board = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @Published var currentPlayer = "X"
    @Published var winner: String?
    
    var winnerText: String {
        if let winner = winner {
            return "\(winner) hat gewonnen!"
        } else {
            return ""
        }
    }
    
    func makeMove(row: Int, column: Int) {
        if board[row][column].isEmpty && winner == nil {
            board[row][column] = currentPlayer
            currentPlayer = (currentPlayer == "X") ? "O" : "X"
            checkForWinner()
            if currentPlayer == "O" {
                makeComputerMove()
            }
        }
    }
    
    func makeComputerMove() {
        guard winner == nil else {
            return
        }
        
        var bestMove: (Int, Int)? = nil
        var bestScore = Int.min
        
        for row in 0..<3 {
            for column in 0..<3 {
                if board[row][column].isEmpty {
                    board[row][column] = currentPlayer
                    let score = minimax(depth: 0, isMaximizingPlayer: false)
                    board[row][column] = ""
                    
                    if score > bestScore {
                        bestScore = score
                        bestMove = (row, column)
                    }
                }
            }
        }
        
        if let move = bestMove {
            board[move.0][move.1] = currentPlayer
            currentPlayer = (currentPlayer == "X") ? "O" : "X"
            checkForWinner()
        }
    }
    
    func minimax(depth: Int, isMaximizingPlayer: Bool) -> Int {
        if checkForWinningCondition(for: "X") {
            return -10 + depth
        } else if checkForWinningCondition(for: "O") {
            return 10 - depth
        } else if isBoardFull() {
            return 0
        }
        
        if isMaximizingPlayer {
            var bestScore = Int.min
            
            for row in 0..<3 {
                for column in 0..<3 {
                    if board[row][column].isEmpty {
                        board[row][column] = "O"
                        let score = minimax(depth: depth + 1, isMaximizingPlayer: false)
                        board[row][column] = ""
                        bestScore = max(bestScore, score)
                    }
                }
            }
            
            return bestScore
        } else {
            var bestScore = Int.max
            
            for row in 0..<3 {
                for column in 0..<3 {
                    if board[row][column].isEmpty {
                        board[row][column] = "X"
                        let score = minimax(depth: depth + 1, isMaximizingPlayer: true)
                        board[row][column] = ""
                        bestScore = min(bestScore, score)
                    }
                }
            }
            
            return bestScore
        }
    }
    
    func checkForWinner() {
        if checkForWinningCondition(for: "X") {
            winner = "X"
        } else if checkForWinningCondition(for: "O") {
            winner = "O"
        } else if isBoardFull() {
            winner = "Unentschieden"
        }
    }
    
    func checkForWinningCondition(for player: String) -> Bool {
        // Überprüfe horizontale Reihen
        for row in 0..<3 {
            if board[row][0] == player && board[row][1] == player && board[row][2] == player {
                return true
            }
        }
        
        // Überprüfe vertikale Reihen
        for column in 0..<3 {
            if board[0][column] == player && board[1][column] == player && board[2][column] == player {
                return true
            }
        }
        
        // Überprüfe diagonale Reihen
        if board[0][0] == player && board[1][1] == player && board[2][2] == player {
            return true
        }
        
        if board[0][2] == player && board[1][1] == player && board[2][0] == player {
            return true
        }
        
        return false
    }
    
    func isBoardFull() -> Bool {
        for row in 0..<3 {
            for column in 0..<3 {
                if board[row][column].isEmpty {
                    return false
                }
            }
        }
        return true
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        currentPlayer = "X"
        winner = nil
    }
}

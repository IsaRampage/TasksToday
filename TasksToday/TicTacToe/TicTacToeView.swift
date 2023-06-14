//
//  TicTacToeView.swift
//  TasksToday
//
//  Created by Isa Rampage on 07.06.23.
//

import SwiftUI

struct TicTacToeView: View {
    @StateObject private var game = TicTacToeGame()
    @State private var showAlert = false
    @State private var animateWinner = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text(game.winnerText)
                .font(.headline)
                .padding(.bottom, 10)
                .opacity(animateWinner ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.5))
                .onAppear {
                    animateWinner = true
                }
            
            VStack(spacing: 0) {
                ForEach(0..<3) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { column in
                            Button(action: {
                                makeMoveWithAnimation(row: row, column: column)
                            }) {
                                Text(game.board[row][column])
                                    .font(.largeTitle)
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 2)
                                    )
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                resetGameWithAnimation()
            }) {
                Text("Restart")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }
        }
        .padding(.bottom, 30)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Gewinner"),
                message: Text(game.winnerText),
                dismissButton: .default(Text("Neues Spiel")) {
                    resetGameWithAnimation()
                }
            )
        }
    }
    
    private func makeMoveWithAnimation(row: Int, column: Int) {
        guard game.board[row][column].isEmpty && game.winner == nil else {
            return
        }
        
        withAnimation(.spring()) {
            game.makeMove(row: row, column: column)
        }
    }
    
    private func resetGameWithAnimation() {
        withAnimation(.easeInOut(duration: 0.5)) {
            game.resetGame()
        }
    }
}
struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}

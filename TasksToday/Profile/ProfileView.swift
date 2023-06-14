//
//  ProfileView.swift
//  TasksToday
//
//  Created by Isa Rampage on 05.05.23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @State private var isPlayingTicTacToe = false
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.black)
                .padding(.bottom, 20)
            
            Text(firebaseViewModel.email)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 20)
            
            Spacer()
            
            Button(action: {
                isPlayingTicTacToe = true
            }) {
                Text("TicTacToe")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                firebaseViewModel.logout()
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }
            .padding()
        }
        .sheet(isPresented: $isPlayingTicTacToe) {
            TicTacToeView()
        }
        .ignoresSafeArea(.all)
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

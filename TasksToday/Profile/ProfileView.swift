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
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: self.width + 200, height: self.width + 200)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .padding(.top, -500)
                
                Spacer()
                
                VStack {
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
                    
                    //  Spacer()
                    
                    Button(action: {
                        isPlayingTicTacToe = true
                    }) {
                        Text("TicTacToe")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                    }
                    .padding()
                    
                    //  Spacer()
                    
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
                .navigationTitle("Profile")
                .ignoresSafeArea(.all)
            }
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(FireBaseViewModel())
    }
}

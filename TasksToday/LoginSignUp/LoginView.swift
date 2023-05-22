//
//  LoginView.swift
//  TasksToday
//
//  Created by Isa Rampage on 16.05.23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var firebaseViewModel: FireBaseViewModel
    @State private var showPassword = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    TextField("Email", text: $firebaseViewModel.email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                    
                    if showPassword { // Passwort anzeigen, wenn showPassword true ist
                        TextField("Password", text: $firebaseViewModel.password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    } else { // Sonst sicheres Textfeld anzeigen
                        SecureField("Password", text: $firebaseViewModel.password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                    
                    // Button mit Auge-Icon zum Anzeigen des Passworts
                    Button(action: { showPassword.toggle() }) {
                        Text("view password")
                        .foregroundColor(.gray)
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    firebaseViewModel.login()
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 40)
                        .frame(maxWidth: 150)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                NavigationLink(destination: RegisterView()) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 40)
                        .frame(maxWidth: 150)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            }
            .padding()
            .navigationBarTitle("Log in")
            .background(Color.white)
        }
    }
}
struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}

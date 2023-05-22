//
//  FireBaseViewModel.swift
//  TasksToday
//
//  Created by Isa Rampage on 16.05.23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SwiftUI
class FireBaseViewModel: ObservableObject{
  // Referenz auf die Firebase Datenbank
  let db = Firestore.firestore()
  // Login Variablen
  @Published var email = ""
  @Published var password = ""
  @Published var username = ""
  @Published var surname = ""
  @Published var lastname = ""
  @Published var gender = ""
  @Published var birthdate = Date()
  @Published var loggedIn = false
  @Published var alertTitle = ""
  @Published var alertMessage = ""
  @Published var showAlert = false
  // der aktuell eingeloggte User
  @Published var currentUser: User? = nil
  func login(){
    if checkLoginFields(){
      Auth.auth().signIn(withEmail: email, password: password){ [weak self] authResult, error in
        guard let strongSelf = self else {return}
        if error == nil && authResult != nil{
          //Todo: statt navPath self ?? FirebaseViewModel
          (self ?? FireBaseViewModel()).loggedIn = true
        }else {
          print (error?.localizedDescription)
        }
      }
    }else {
      print ("Please check the fields.")
    }
  }
  //
  func signUp(){
    if checkSignUpFields(){
      Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
        guard let strongSelf = self else {return}
      }
    }else {
      print("Please check the fields")
    }
  }
  func checkUser(){
    if let user = Auth.auth().currentUser{
      currentUser = user
    }else {
      print ("User is not logged in")
    }
  }
  func logout(){
    do{
      try Auth.auth().signOut()
      currentUser = nil
      loggedIn = false
    }catch let signError as NSError{
      print ("Error: \(signError)")
    }
  }
  func clearAllLoginField(){
    email = ""
    password = ""
    username = ""
    surname = ""
    lastname = ""
    gender = ""
    birthdate = Date()
  }
  func checkLoginFields() -> Bool{
    if (!email.isEmpty && !password.isEmpty){
      return true
    }
    else {
      return false
    }
  }
  func checkSignUpFields() -> Bool {
    if (!email.isEmpty && !password.isEmpty){
      if (password != password){
        return false
      }
      else {
        return true
      }
    }
    else {
      return false
    }
  }
  func saveUser() {
    guard let currentUser = currentUser else {
      print("User is not logged in")
      return
    }
    let userDocument = db.collection("Users").document(currentUser.uid)
    let userData: [String: Any] = [
      "email": email,
      "username": username,
      "surname": surname,
      "lastname": lastname,
      "gender": gender,
      "birthdate": birthdate
    ]
    userDocument.setData(userData) { error in
      if let error = error {
        print("Error saving user data: \(error.localizedDescription)")
      } else {
        print("User data saved successfully")
      }
    }
  }
}

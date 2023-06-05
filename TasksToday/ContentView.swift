//
//  ContentView.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var fireBaseVM: FireBaseViewModel
    @State var selectedTab: String = "list.bullet"
    @State var screenTitle: String = ""
   
    
    var body: some View {
        
        if fireBaseVM.loggedIn {
        ZStack {
                
                VStack(spacing: 0) {
                    ZStack {
                        RoundedShapeHead(corners: [.bottomLeft, .bottomRight])
                            .fill(Color.blue)
                            .frame(width: 450, height: 180)
                            .offset(x: -90, y: -60) // Position des Shapes anpassen
                    }
                    .padding(.bottom, -50)
                    
                    // Main View based on tab selection...
                    switch(selectedTab) {
                    case "list.bullet":
                        TasksView()
                        Text("Tasks")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .offset(x: -140, y: -600)
                    case "calendar":
                        DailyTasksView()
                        Text("Daily Tasks")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .offset(x: -100, y: -600)
                    case "cart":
                        ShoppingListView()
                        Text("Shopping List")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .offset(x: -80, y: -600)
                    case "person":
                        ProfileView()
                        Text("Profile")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .offset(x: -135, y: -600)
                    default:
                        TasksView()
                    }
                    //      Einträge in der Datenbank prüfen...
                    // Text("\(viewModel.tasks.count)")
                    
                    // Custom Tab Bar...
                    CustomTabBar(selectedTab: $selectedTab)
                }
                
                //  .background(Color.black.opacity(0.07).ignoresSafeArea())
                .background(Color.white.opacity(0.07).ignoresSafeArea())
            } 
        }  else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

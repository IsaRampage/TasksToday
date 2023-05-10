//
//  ContentView.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: String = "list.bullet"
    @State var screenTitle: String = ""
    
    var body: some View {
        ZStack {
            
            
            VStack(spacing: 0) {
                //                ZStack {
                //                    RoundedShapeHead(corners: [.bottomLeft, .bottomRight])
                //                        .fill(Color.blue)
                //                        .frame(width: 450, height: 180)
                //                        .offset(x: -100, y: -60) // Position des Shapes anpassen
                //                    Text(screenTitle)
                //                        .font(.largeTitle)
                //                        .bold()
                //                        .offset(x: -140, y: -20)
                //                }
                
                // Main View based on tab selection...
                switch(selectedTab) {
                case "list.bullet":
                    TasksView()
                case "calendar":
                    DailyTasksView()
                case "cart":
                    ShoppingListView()
                case "person":
                    ProfileView()
                default:
                    TasksView()
                }
                //      Einträge in der Datenbank prüfen...
                //      Text("\(viewModel.tasks.count)")
                
                // Custom Tab Bar...
                CustomTabBar(selectedTab: $selectedTab)
            }
            
            //  .background(Color.black.opacity(0.07).ignoresSafeArea())
            .background(Color.white.opacity(0.07).ignoresSafeArea())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

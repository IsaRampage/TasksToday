//
//  ContentView.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

/*struct ContentView: View {
    
    @State var selectedTab = "house"
    var body: some View {
        
        ZStack(alignment: .bottom, content: {
           
            Color(.blue)
                .ignoresSafeArea()
            
            // Custom Tab Bar...
            
            CustomTabBar(selectedTab: $selectedTab)
        })
    }
}
*/
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

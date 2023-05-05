//
//  SplashScreenView.swift
//  TasksToday
//
//  Created by Isa Rampage on 05.05.23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var showMainView = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Bild oder Animation des Splash Screens
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .opacity(showMainView ? 0 : 1)
                    .onAppear {
                        withAnimation(Animation.easeOut(duration: 1.5).delay(0.5)) {
                            self.showMainView.toggle()
                        }
                    }
                
                // Text unter dem Bild
                Text("Tasks Today")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .opacity(showMainView ? 0 : 1)
                    .offset(y: showMainView ? -50 : 50)
                    .animation(Animation.easeOut(duration: 1.5).delay(1.0))
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

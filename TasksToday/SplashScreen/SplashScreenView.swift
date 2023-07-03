//
//  SplashScreenView.swift
//  TasksToday
//
//  Created by Isa Rampage on 05.05.23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var showMainView = false
    @State private var circleScale: CGFloat = 0.2
    
    var body: some View {
        ZStack {
            Color.white // Weißer Hintergrund
            
            VStack {
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
                
                Text("Tasks Today")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .opacity(showMainView ? 0 : 1)
                    .offset(y: showMainView ? -50 : 50)
                    .animation(Animation.easeOut(duration: 1.5).delay(1.0))
                
                Circle() // Gelber Kreis
                    .fill(Color.yellow)
                    .frame(width: circleScale * 500, height: circleScale * 500)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .padding(.top, circleScale * -835) // Ursprünglicher Y-Offset der LoginView
                    .scaleEffect(circleScale)
                    .animation(.spring())
                    .onAppear {
                        circleScale = 1.0 // Größere Größe für den Kreis
                    }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

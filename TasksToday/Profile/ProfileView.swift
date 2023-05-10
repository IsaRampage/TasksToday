//
//  ProfileView.swift
//  TasksToday
//
//  Created by Isa Rampage on 05.05.23.
//

import SwiftUI

struct ProfileView: View {
    @State private var backgroundColor = Color.white
    @State private var foregroundColor = Color.black
    
    var body: some View {
            VStack {
                Spacer()
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(foregroundColor)
                    .padding(.bottom, 20)
                
                Text("Benutzername")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(foregroundColor)
                    .padding(.bottom, 20)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Hintergrundfarbe")
                        .font(.headline)
                    
                    ColorPicker("", selection: $backgroundColor)
                    
                    Text("Vordergrundfarbe")
                        .font(.headline)
                    
                    ColorPicker("", selection: $foregroundColor)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 20)
                
                Spacer()
            }
        .background(backgroundColor)
        .ignoresSafeArea(.all)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

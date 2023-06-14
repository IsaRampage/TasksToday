//
//  CircleHead.swift
//  TasksToday
//
//  Created by Isa Rampage on 14.06.23.
//

import SwiftUI

struct CircleHead: View {
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.yellow)
                .frame(width: self.width + 200, height: self.width + 200)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
        }
        .padding(.top, -500)
    }
}

struct CircleHead_Previews: PreviewProvider {
    static var previews: some View {
        CircleHead()
    }
}

//
//  TasksListRowBackground.swift
//  TasksToday
//
//  Created by Isa Rampage on 10.05.23.
//

import SwiftUI

struct TasksListRowBackground: View {
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 350, height: geometry.size.height)
                .background(Color(.sRGB, red: 0.0, green: 0.5, blue: 1.0, opacity: 0.3))
                .cornerRadius(10)
        }
    }
}

struct TasksListRowBackground_Previews: PreviewProvider {
    static var previews: some View {
        TasksListRowBackground()
    }
}

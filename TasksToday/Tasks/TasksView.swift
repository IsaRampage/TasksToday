//
//  TasksView.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI
import CoreData

struct TasksView: View {
    @State private var newTaskTitle = ""
    @ObservedObject private var tasksModel = TasksModel()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
                .zIndex(-1)

            VStack {
                if tasksModel.tasks.isEmpty {
                    Spacer()
                } else {
                    VStack {
                        List {
                            ForEach(tasksModel.tasks, id: \.id) { task in
                                if !task.isCompleted {
                                    HStack {
                                        Text(task.title ?? "")
                                        Spacer()
                                        Button(action: {
                                            tasksModel.markAsCompleted(task)
                                        }) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                tasksModel.deleteTask(indexSet: indexSet)
                            }
                        }
                        .listStyle(.plain)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()
                    }
                }

                HStack {
                    TextField("New Task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        tasksModel.addTask(newTaskTitle)
                        newTaskTitle = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                .padding()
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}

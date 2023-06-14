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
    @StateObject private var tasksModel = TasksModel()
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: self.width + 200, height: self.width + 200)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .padding(.top, -500)
                HStack {
                    TextField("New Task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        tasksModel.addTask(newTaskTitle)
                        newTaskTitle = ""
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.bottom)
                .padding(.top)
                
                // Text("\(tasksModel.tasks.count)")
                if tasksModel.tasks.isEmpty {
                    Spacer()
                    
                } else {
                    VStack {
                        List {
                            Section {
                                ForEach(tasksModel.tasks, id: \.id) { task in
                                    if !task.isCompleted {
                                        HStack {
                                            Text(task.title ?? "")
                                            Spacer()
                                            Button(action: {
                                                tasksModel.updateTask(task: task)
                                            }) {
                                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                            }
                                        }
                                    }
                                }
                                .onDelete { indexSet in
                                    tasksModel.deleteTask(indexSet: indexSet)
                                }
                            }
                            .listRowBackground(TasksListRowBackground())
                            
                        }
                        .frame(width: 350)
                        .listStyle(PlainListStyle())
                    }
                    .padding(.bottom, -25)
                    
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}

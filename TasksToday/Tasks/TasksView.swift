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
    
    var body: some View {
        NavigationStack{
            VStack {
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
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                .onDelete { indexSet in
                                    tasksModel.deleteTask(indexSet: indexSet)
                                }
                            }
                            
                        }
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
            .navigationTitle("Tasks")
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}

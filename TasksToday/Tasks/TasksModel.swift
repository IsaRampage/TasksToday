//
//  TasksModel.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import Foundation

class TasksModel: ObservableObject {
    @Published var tasks: [Tasks] = []
    
    func addTask(_ title: String) {
        let newTask = Tasks(title: title)
        tasks.append(newTask)
    }
    
    func markAsCompleted(_ task: Tasks) {
        if let index = tasks.firstIndex(where: { $0.id == task.id}) {
            tasks[index].isCompleted = true
        }
    }
    
    func deleteTask(_ task: Tasks) {
        if let index = tasks.firstIndex(where: { $0.id == task.id}) {
            tasks.remove(at: index)
        }
    }
}

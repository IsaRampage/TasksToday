//
//  TasksModel.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI
import CoreData
import Foundation


@MainActor
class TasksModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var tasks: [Tasks] = []
    
    init() {
        container = NSPersistentContainer(name: "TasksDataModel")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("core data store failed: \(error.localizedDescription)")
            }
        }
        
        fetchTasks()
    }
    
    func fetchTasks() {
        let request = NSFetchRequest<Tasks>(entityName: "Tasks")
        
        do {
            tasks = try container.viewContext.fetch(request)
        } catch {
            print("error fetching: \(error)")
        }
    }
    
    func saveTask(title: String) {
        let newTask = Tasks(context: container.viewContext)
        newTask.title = title
        newTask.isCompleted = false
        
        do {
            try container.viewContext.save()
            fetchTasks()
        } catch {
            print("Error while saving a new task \(error)")
        }
    }
    
    func updateTask(task: Tasks) {
        task.isCompleted.toggle()
        
        do {
            try container.viewContext.save()
            fetchTasks()
        } catch {
            print("Error while updating a task \(error)")
        }
    }
    
    func deleteTask(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            print("No index inside IndexSet")
            return
        }
        
        let taskToDelete = tasks[index]
        container.viewContext.delete(taskToDelete)
        
        do {
            try container.viewContext.save()
            fetchTasks()
        } catch {
            print("Error while deleting a task \(error)")
        }
    }
    
    func markAsCompleted(_ task: Tasks) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
        }
    }
    
    func addTask(_ title: String) {
        let newTask = Tasks(context: container.viewContext)
        newTask.title = title
        newTask.isCompleted = false
        
        do {
            try container.viewContext.save()
            tasks.append(newTask)
        } catch let error {
            print("Error while saving task. \(error.localizedDescription)")
        }
    }
    
    func deleteAllTasks() {
        for task in tasks {
          container.viewContext.delete(task)
        }
        do {
          try container.viewContext.save()
          fetchTasks()
        } catch {
          print("Error while deleting a task \(error)")
        }
      }
}

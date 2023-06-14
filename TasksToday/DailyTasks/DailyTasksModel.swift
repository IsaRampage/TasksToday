//
//  DailyTasksModel.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import Foundation
import CoreData

class DailyTasksModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var dailyTasks: [DailyTasks] = []
    
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
        let request = NSFetchRequest<DailyTasks>(entityName: "DailyTasks")
        
        do {
            dailyTasks = try container.viewContext.fetch(request)
            DispatchQueue.main.async { [weak self] in
                self?.objectWillChange.send()
            }
        } catch {
            print("error fetching: \(error)")
        }
    }
    
    //init() {
    //  resetCompletedTasksIfNeeded()
    // }
    
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
    
    func updateTask(task: DailyTasks) {
        task.isCompleted.toggle()
        task.lastCompletedDate = task.isCompleted ? Date() : nil
        
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
        
        let taskToDelete = dailyTasks[index]
        container.viewContext.delete(taskToDelete)
        
        do {
            try container.viewContext.save()
            fetchTasks()
        } catch {
            print("Error while deleting a task \(error)")
        }
    }
    
    func markAsCompleted(_ task: DailyTasks) {
        if let index = dailyTasks.firstIndex(where: { $0.id == task.id }) {
            dailyTasks[index].isCompleted = true
        }
    }
    
    func addTask(_ title: String) {
        let newTask = DailyTasks(context: container.viewContext)
        newTask.title = title
        newTask.isCompleted = false
        
        do {
            try container.viewContext.save()
            dailyTasks.append(newTask)
        } catch let error {
            print("Error while saving task. \(error.localizedDescription)")
        }
    }
    
    func resetCompletedTasksIfNeeded() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        for i in 0..<dailyTasks.count {
            if let lastCompletedDate = dailyTasks[i].lastCompletedDate {
                let lastCompletedDay = calendar.startOfDay(for: lastCompletedDate)
                if lastCompletedDay < today {
                    dailyTasks[i].isCompleted = false
                    dailyTasks[i].shouldDisplay = false
                    dailyTasks[i].lastCompletedDate = nil
                }
            }
        }
    }
}

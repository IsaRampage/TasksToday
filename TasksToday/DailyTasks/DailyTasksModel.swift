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
    
    @Published var dailyTasks: [Tasks] = []

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
           dailyTasks = try container.viewContext.fetch(request)
        } catch {
            print("error fetching: \(error)")
        }
    }
    
    //init() {
      //  resetCompletedTasksIfNeeded()
    }



    func addTask(_ title: String) {
        let newTask = Tasks(context: container.viewContext)
        dailyTasks.append(newTask)
    }

    func completeTask(_ task: DailyTasks) {
        if let index = dailyTasks.firstIndex(where: { $0.id == task.id }) {
            dailyTasks[index].completeTask()
        }
    }

    func deleteTask(indexSet: IndexSet) {
        dailyTasks.remove(atOffsets: indexSet)
    }

    private func resetCompletedTasksIfNeeded() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        for i in 0..<dailyTasks.count {
            if let lastCompletedDate = dailyTasks[i].lastCompletedDate {
                let lastCompletedDay = calendar.startOfDay(for: lastCompletedDate)
                if lastCompletedDay < today {
                    dailyTasks[i].shouldDisplay = false
                }
            }
        }
    }
}

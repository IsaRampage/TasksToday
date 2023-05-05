//
//  DailyTasksModel.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import Foundation

class DailyTasksModel: ObservableObject {
    @Published var dailyTasks: [DailyTasks] = [
        DailyTasks(title: "Drink water", lastCompletedDate: Date())
    ]

    init() {
        resetCompletedTasksIfNeeded()
    }

    func addTask(_ title: String) {
        let newTask = DailyTasks(title: title)
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

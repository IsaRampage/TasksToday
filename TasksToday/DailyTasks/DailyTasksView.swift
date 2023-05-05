//
//  DailyTasksView.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI

struct DailyTasksView: View {
    @ObservedObject private var dailyTasksModel = DailyTasksModel()

    @State private var newTaskTitle = ""

    var body: some View {
        VStack {
            List {
                ForEach(dailyTasksModel.dailyTasks.filter({ $0.shouldDisplay })) { task in
                    HStack {
                        Text(task.title)
                        Spacer()
                        if task.lastCompletedDate == nil {
                            Button(action: {
                                dailyTasksModel.completeTask(task)
                            }) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    dailyTasksModel.deleteTask(indexSet: indexSet)
                }
            }
            HStack {
                TextField("New Task", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    dailyTasksModel.addTask(newTaskTitle)
                    newTaskTitle = ""
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .padding()
        }
    }
}

struct DailyTasksView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTasksView()
    }
}

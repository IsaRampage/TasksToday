//
//  DailyTasksView.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI
import CoreData

struct DailyTasksView: View {
    @StateObject private var dailyTasksModel = DailyTasksModel()

    @State private var newTaskTitle = ""

    var body: some View {
            VStack {
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
                .padding(.horizontal, 25)
                .padding(.bottom)
                .padding(.top)
                
                List {
                    Section {
                        ForEach(dailyTasksModel.dailyTasks.filter({ $0.shouldDisplay })) { task in
                            HStack {
                                Text(task.title ?? "")
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
                            $dailyTasksModel.deleteTask(indexSet: indexSet)
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

struct DailyTasksView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTasksView()
    }
}

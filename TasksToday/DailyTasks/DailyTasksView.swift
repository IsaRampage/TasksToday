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
    var newArray = ["2, 3, 4"]
    
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
                    ForEach(dailyTasksModel.dailyTasks, id: \.id) { dailyTask in
                        
                        HStack {
                            if dailyTask.isCompleted {
                                Text(dailyTask.title ?? "")
                                    .foregroundColor(.gray)
                                    .strikethrough()
                            } else {
                                Text(dailyTask.title ?? "")
                            }
                            Spacer()
                            
                            Button {
                                dailyTasksModel.updateTask(task: dailyTask)
                            } label: {
                                Image(systemName: dailyTask.isCompleted ? "checkmark.circle.fill" : "circle")
                            }
                        }
                        
                    }
                    .onDelete { indexSet in
                        dailyTasksModel.deleteTask(indexSet: indexSet)
                    }
                }
                .listRowBackground(TasksListRowBackground())
            }
            .frame(width: 350)
            .listStyle(PlainListStyle())
        }
        .padding(.bottom, -25)
        .onAppear {
            dailyTasksModel.resetCompletedTasksIfNeeded()
        }
    }
}

struct DailyTasksView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTasksView()
    }
}

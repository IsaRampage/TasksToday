//
//  DailyTasksView.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI
import CoreData

struct DailyTasksView: View {
    @State var width = UIScreen.main.bounds.width
    @StateObject private var dailyTasksModel = DailyTasksModel()
    var newArray = ["2, 3, 4"]
    
    @State private var newTaskTitle = ""
    
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
                        dailyTasksModel.addTask(newTaskTitle)
                        newTaskTitle = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.black)
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
            .navigationTitle("Daily Tasks")
        }
    }
}

struct DailyTasksView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTasksView()
    }
}

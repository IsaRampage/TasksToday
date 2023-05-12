//
//  DailyTasks.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

//import Foundation
//
//struct DailyTasks: Identifiable {
//    var id = UUID()
//    var title: String
//    var lastCompletedDate: Date?
//    var shouldDisplay: Bool {
//        get {
//            if let lastCompletedDate = lastCompletedDate {
//                let calendar = Calendar.current
//                let today = calendar.startOfDay(for: Date())
//                let lastCompletedDay = calendar.startOfDay(for: lastCompletedDate)
//                return lastCompletedDate < today
//            } else {
//                return true
//            }
//        }
//        set {
//            // Setter wird nicht benötigt, da `shouldDisplay` automatisch berechnet wird.
//        }
//    }
//    
//    mutating func completeTask() {
//        lastCompletedDate = Date()
//    }
//}

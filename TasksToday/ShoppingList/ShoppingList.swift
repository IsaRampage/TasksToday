//
//  ShoppingList.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import Foundation

struct ShoppingList: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}

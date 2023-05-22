//
//  ShoppingListModel.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import Foundation

class ShoppingListModel: ObservableObject {
    @Published var shoppingList: [ShoppingList] = [
        ShoppingList(title: "Apples", istCompleted: false),
        ShoppingList(title: "Milk", istCompleted: true),
        ShoppingList(title: "Bread", istCompleted: false)
    ]
    
    func addItem(_ item: ShoppingList) {
        shoppingList.append(item)
    }
    
    func toggleItem(_ item: ShoppingList) {
        if let index = shoppingList.firstIndex(where: { $0.id == item.id }) {
            shoppingList[index].istCompleted.toggle()
        }
    }
    
    func deleteItem(_ item: ShoppingList) {
        if let index = shoppingList.firstIndex(where: { $0.id == item.id }) {
            shoppingList.remove(at: index)
        }
    }
}

//
//  ShoppingListModel.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import Foundation
import CoreData

class ShoppingListModel: ObservableObject {
 /*   @Published var shoppingList: [ShoppingList] = [
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
    } */
    
    let container: NSPersistentContainer
    
    @Published var shoppingList: [ShoppingList] = []

    init() {
        container = NSPersistentContainer(name: "TasksDataModel")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("core data store failed: \(error.localizedDescription)")
            }
        }
        
        fetchItems()
    }
    
    func fetchItems() {
        let request = NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
        
        do {
           shoppingList = try container.viewContext.fetch(request)
            print(shoppingList)
        } catch {
            print("error fetching: \(error)")
        }
    }

func saveItem(title: String) {
    let newItem = ShoppingList(context: container.viewContext)
    newItem.id = UUID()
    newItem.title = title
    newItem.isItCompleted = false
    
    do {
        try container.viewContext.save()
        fetchItems()
    } catch {
        print("Error while saving a new task \(error)")
    }
}
    
    func updateItem(item: ShoppingList) {
        item.isItCompleted.toggle()
        
        do {
            try container.viewContext.save()
            fetchItems()
        } catch {
            print("Error while updating a task \(error)")
        }
    }
    
    func deleteItem(_ item: ShoppingList) {
       
        container.viewContext.delete(item)
        
        do {
            try container.viewContext.save()
            fetchItems()
        } catch {
            print("Error while deleting a task \(error)")
        }
    }
    
    func markAsCompleted(_ item: ShoppingList) {
        item.isItCompleted.toggle()
        do {
            try container.viewContext.save()
            fetchItems()
        } catch let error {
            print("Error while saving task. \(error.localizedDescription)")
        }
    }

    func addItem(_ title: String) {
        let newItem = ShoppingList(context: container.viewContext)
        newItem.id = UUID()
        newItem.title = title
        newItem.isItCompleted = false
        
        do {
            try container.viewContext.save()
            fetchItems()
        } catch let error {
            print("Error while saving task. \(error.localizedDescription)")
        }
    }
}



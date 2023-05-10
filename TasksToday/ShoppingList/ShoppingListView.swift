//
//  ShoppingListView.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI

struct ShoppingListView: View {
    @ObservedObject private var shoppingListModel = ShoppingListModel()
    @State private var newItemTitle = ""
    
    var body: some View {
            VStack {
                HStack {
                    TextField("Add new item", text: $newItemTitle)
                    Button(action: {
                        let newItem = ShoppingList(title: newItemTitle, isCompleted: false)
                        shoppingListModel.addItem(newItem)
                        newItemTitle = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                .padding()
                
                List {
                    ForEach(shoppingListModel.shoppingList) { item in
                        HStack {
                            Button(action: {
                                shoppingListModel.toggleItem(item)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Text(item.title)
                                .strikethrough(item.isCompleted)
                            
                            Spacer()
                            
                            Button(action: {
                                shoppingListModel.deleteItem(item)
                            }) {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}

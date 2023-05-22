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
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        let newItem = ShoppingList(title: newItemTitle, istCompleted: false)
                        shoppingListModel.addItem(newItem)
                        newItemTitle = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                .padding(.horizontal, 25)
                .padding(.bottom)
                .padding(.top)
                
                List {
                    Section {
                        ForEach(shoppingListModel.shoppingList) { item in
                            HStack {
                                Button(action: {
                                    shoppingListModel.toggleItem(item)
                                }) {
                                    Image(systemName: item.istCompleted ? "checkmark.circle.fill" : "circle")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                
                                Text(item.title)
                                    .strikethrough(item.istCompleted)
                                
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
                    .listRowBackground(TasksListRowBackground())
                }
                .frame(width: 350)
                .listStyle(PlainListStyle())
            }
            .padding(.bottom, -25)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}

//
//  ShoppingListView.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI
import CoreData

struct ShoppingListView: View {
    @ObservedObject private var shoppingListModel = ShoppingListModel()
    @State private var newItemTitle = ""
    @ObservedObject private var weatherViewModel = WeatherApiViewModel()
    @State private var isShowingWeatherSheet = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add new item", text: $newItemTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                 //   let newItem = ShoppingList(title: newItemTitle, isItCompleted: false)
                    shoppingListModel.addItem(newItemTitle)
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
                                shoppingListModel.markAsCompleted(item)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
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
            
            Button(action: {
                let weatherCity = "Hamburg"
                weatherViewModel.fetchWeather(city: weatherCity)
                isShowingWeatherSheet = true
            }) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.blue)
                    .padding(.trailing, 5)
                Text("Hamburg")
                
            }
            .sheet(isPresented: $isShowingWeatherSheet) {
                WeatherView(viewModel: weatherViewModel)
            }
            .padding(.horizontal, 25)
            .padding(.bottom)
        }
        .padding(.bottom, -25)
    }
}


struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}

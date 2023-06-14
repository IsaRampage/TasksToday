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
                    ForEach(shoppingListModel.shoppingList) { newItem in
                        HStack {
                            Button(action: {
                                shoppingListModel.markAsCompleted(newItem)
                            }) {
                                Image(systemName: newItem.isItCompleted ? "checkmark.circle.fill" : "circle")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Text(newItem.title ?? "")
                                .strikethrough(newItem.isItCompleted)
                            
                            Spacer()
                            
                            Button(action: {
                                shoppingListModel.deleteItem(newItem)
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

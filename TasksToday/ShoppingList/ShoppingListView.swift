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
    @State var width = UIScreen.main.bounds.width
    
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
                    TextField("Add new item", text: $newItemTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        shoppingListModel.addItem(newItemTitle)
                        newItemTitle = ""
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
                        ForEach(shoppingListModel.shoppingList) { newItem in
                            HStack {
                                Button(action: {
                                    shoppingListModel.markAsCompleted(newItem)
                                }) {
                                    Image(systemName: newItem.isItCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(.black)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                
                                Text(newItem.title ?? "")
                                    .strikethrough(newItem.isItCompleted)
                                
                                Spacer()
                                
                                Button(action: {
                                    shoppingListModel.deleteItem(newItem)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.black)
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
                .padding(.bottom, -40)
            }
            .padding(.bottom, +25)
            .navigationTitle("Shopping List")
        }
    }
}


struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}

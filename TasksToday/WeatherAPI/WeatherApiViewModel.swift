//
//  WeatherApiViewModel.swift
//  TasksToday
//
//  Created by Isa Rampage on 30.05.23.
//

import SwiftUI
class WeatherApiViewModel: ObservableObject {
    @Published var weather: Weather?
    
    
    func fetchWeather(city: String) {
        let city = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/weather?city=\(city!)")!
        var request = URLRequest(url: url)
        request.setValue("9nTWqe7ZYRlWTVoFjfpYYg==ekBbvC8tR5lHqNMZ", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.weather = nil
                }
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(Weather.self, from: data) {
                DispatchQueue.main.async {
                    self?.weather = decodedResponse
                }
            } else {
                DispatchQueue.main.async {
                    self?.weather = nil
                }
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
            } else {
                DispatchQueue.main.async {
                    self?.weather = nil
                    print("Decoding failed")
                }
            }
        }
        
        task.resume()
    }
}

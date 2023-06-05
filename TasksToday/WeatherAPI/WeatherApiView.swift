//
//  WeatherApiView.swift
//  TasksToday
//
//  Created by Isa Rampage on 30.05.23.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherApiViewModel()
    @State private var city = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("City", text: $city)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                viewModel.fetchWeather(city: city)
            }) {
                Text("Get Weather")
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if let weather = viewModel.weather {
                VStack(spacing: 10) {
                    WeatherInfoView(label: "Temperature", value: "\(weather.temp)°C")
                    WeatherInfoView(label: "Min Temperature", value: "\(weather.min_temp)°C")
                    WeatherInfoView(label: "Max Temperature", value: "\(weather.max_temp)°C")
                    WeatherInfoView(label: "Sunset", value: formatTime(weather.sunset))
                    WeatherInfoView(label: "Sunrise", value: formatTime(weather.sunrise))
                }
                .font(.headline)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            } else {
                Text("No weather data available")
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
    
    private func formatTime(_ time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct WeatherInfoView: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.bold)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

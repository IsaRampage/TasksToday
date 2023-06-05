//
//  WeatherStruct.swift
//  TasksToday
//
//  Created by Isa Rampage on 30.05.23.
//

import Foundation

struct Weather: Codable, Hashable {
  var wind_speed : Float
  var wind_degrees : Int
  var temp : Int
  var humidity : Int
  var sunset : Int
  var min_temp : Int
  var cloud_pct : Int
  var feels_like : Int
  var sunrise : Int
  var max_temp : Int
}

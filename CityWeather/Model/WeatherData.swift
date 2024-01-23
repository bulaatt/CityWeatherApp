//
//  WeatherData.swift
//  CityWeather
//
//  Created by Булат Камалетдинов on 21.01.2024.
//

import UIKit

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Wind: Codable {
    let speed: Double
}

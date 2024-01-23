//
//  WeatherModel.swift
//  CityWeather
//
//  Created by Булат Камалетдинов on 21.01.2024.
//

import UIKit

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let feelsLikeTemperature: Double
    let windSpeed: Double
    
    var temperatureString: String {
        let roundedValue = String(Int(round(temperature)))
        return roundedValue
    }
    
    var feelsLikeTemperatureString: String {
        let roundedValue = String(Int(round(feelsLikeTemperature)))
        return roundedValue
    }
    
    var windSpeedString: String {
        let roundedValue = String(Int(round(windSpeed)))
        return roundedValue
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "wind"
        }
    }
}

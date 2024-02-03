//
//  WeatherManager.swift
//  CityWeather
//
//  Created by Булат Камалетдинов on 21.01.2024.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlCityName = cityName.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "[\\- ]", with: "%20", options: .regularExpression)
        let urlString = "\(weatherURL)&q=\(urlCityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let feels_like = decodedData.main.feels_like
            let speed = decodedData.wind.speed
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, feelsLikeTemperature: feels_like, windSpeed: speed)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

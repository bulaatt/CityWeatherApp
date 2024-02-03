//
//  WeatherViewController.swift
//  CityWeather
//
//  Created by Булат Камалетдинов on 21.01.2024.
//

import UIKit
import CoreLocation

let locationButton = UIButton()
var weatherManager = WeatherManager()
var searchTextField = UITextField()
var conditionImageView = UIImageView(image: UIImage(systemName: "wind"))
var temperatureLabel = UILabel()
var cityLabel = UILabel()
var feelsLikeLabel = UILabel()
var windSpeedLabel = UILabel()

// MARK: - WeatherViewController
class WeatherViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    let weatherParametersView = WeatherParametersView()
    let weatherView = WeatherView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        locationButton.addTarget(self, action: #selector(locationPressed), for: .touchUpInside)
        
        setupView()
    }
    
    @objc func locationPressed() {
        locationManager.startUpdatingLocation()
    }
}

// MARK: - WeatherParametersView
class WeatherParametersView: UIView {
    func style() {
        // Search TextField
        searchTextField.placeholder = "Search city"
        searchTextField.font = .systemFont(ofSize: 20, weight: .regular)
        searchTextField.autocapitalizationType = .words
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemGray5
        // Condition Image
        conditionImageView.tintColor = UIColor(named: "ColorImage")
        conditionImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        // Temperature Label
        temperatureLabel.text = "Temperature"
        temperatureLabel.font = .systemFont(ofSize: 36, weight: .bold)
        
        // Feels Like Label
        feelsLikeLabel.text = "Feels Like Temperature"
        feelsLikeLabel.font = .systemFont(ofSize: 28, weight: .bold)
        
        // Wind Speed Label
        windSpeedLabel.text = "Wind Speed"
        windSpeedLabel.font = .systemFont(ofSize: 28, weight: .bold)
        
        // City Label
        cityLabel.text = "Name of city"
        cityLabel.font = .systemFont(ofSize: 28, weight: .bold)
        cityLabel.numberOfLines = 0
        
        // Location Button
        locationButton.configuration = .filled()
        locationButton.configuration?.baseBackgroundColor = .systemPink
        locationButton.configuration?.title = "Get your weather"
    }
}

// MARK: - Setting views
extension WeatherViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "CityWeatherApp"
        
        addSubViews()
        setupLayout()
        weatherParametersView.style()
    }
}

// MARK: - Adding subviews
extension WeatherViewController {
    func addSubViews() {
        view.addSubview(searchTextField)
        view.addSubview(conditionImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(feelsLikeLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(cityLabel)
        view.addSubview(locationButton)
    }
}

// MARK: - Layout
extension WeatherViewController {
    func setupLayout() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Search TextField
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            searchTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchTextField.trailingAnchor, multiplier: 12)
        ])
        
        // Condition Image
        NSLayoutConstraint.activate([
            conditionImageView.topAnchor.constraint(equalToSystemSpacingBelow: searchTextField.bottomAnchor, multiplier: 4),
            conditionImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            conditionImageView.widthAnchor.constraint(equalToConstant: 100),
            conditionImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Temperature Label
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalToSystemSpacingBelow: conditionImageView.bottomAnchor, multiplier: 3),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: temperatureLabel.trailingAnchor, multiplier: 2)
        ])
        
        // Feels Like Label
        NSLayoutConstraint.activate([
            feelsLikeLabel.topAnchor.constraint(equalToSystemSpacingBelow: temperatureLabel.bottomAnchor, multiplier: 3),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelsLikeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: feelsLikeLabel.trailingAnchor, multiplier: 2)
        ])
        
        // Wind Speed Label
        NSLayoutConstraint.activate([
            windSpeedLabel.topAnchor.constraint(equalToSystemSpacingBelow: feelsLikeLabel.bottomAnchor, multiplier: 3),
            windSpeedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            windSpeedLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: windSpeedLabel.trailingAnchor, multiplier: 2)
        ])
        
        // City Label
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalToSystemSpacingBelow: windSpeedLabel.bottomAnchor, multiplier: 3),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: cityLabel.trailingAnchor, multiplier: 2)
        ])
        
        // Location Button
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalToSystemSpacingBelow: cityLabel.bottomAnchor, multiplier: 3),
            locationButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: locationButton.trailingAnchor, multiplier: 12)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type the name of city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            temperatureLabel.text = "\(weather.temperatureString)°C"
            conditionImageView.image = UIImage(systemName: weather.conditionName)
            cityLabel.text = "City: \(weather.cityName)"
            feelsLikeLabel.text = "Feels Like: \(weather.feelsLikeTemperatureString)°C"
            windSpeedLabel.text = "Wind: \(weather.windSpeedString) m/s"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

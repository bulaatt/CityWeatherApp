//
//  WeatherView.swift
//  CityWeather
//
//  Created by Булат Камалетдинов on 21.01.2024.
//

import UIKit

class WeatherView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

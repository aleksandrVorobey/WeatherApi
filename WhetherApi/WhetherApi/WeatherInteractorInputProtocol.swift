//
//  WeatherInteractorInputProtocol.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//

import CoreLocation

protocol WeatherInteractorInputProtocol: AnyObject {
    func fetchWeather(for location: LocationCoordinate)
}

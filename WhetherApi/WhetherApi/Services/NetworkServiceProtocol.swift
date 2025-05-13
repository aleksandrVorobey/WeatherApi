//
//  NetworkServiceProtocol.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//


protocol NetworkServiceProtocol {
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponseData, NetworkError>) -> Void)
}

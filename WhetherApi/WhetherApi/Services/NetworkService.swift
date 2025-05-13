//
//  NetworkService.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//


import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case noData
    case decodingError(Error)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let apiKey = "fa8b3df74d4042b9aa7135114252304"
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponseData, NetworkError>) -> Void) {
        let coordinate = "\(latitude),\(longitude)"
        
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(coordinate)&days=7") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponseData.self, from: data)
                completion(.success(weatherData))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
            
        }.resume()
        
    }
}

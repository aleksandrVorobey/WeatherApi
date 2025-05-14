//
//  WeatherInteractor.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//


import Foundation

final class WeatherInteractor: WeatherInteractorInputProtocol {
    
    weak var presenter: WeatherInteractorOutputProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchWeather(for location: LocationCoordinate) {
        networkService.fetchWeather(latitude: location.latitude, longitude: location.longitude) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.presenter?.weatherFetchSuccess(data: data)
                case .failure(_):
                    self?.presenter?.weatherFetchFailed()
                }
            }
        }
    }
    
    func filterHourlyData(from forecast: [ForecastDay]) -> [HourWeather] {
        guard !forecast.isEmpty else { return [] }
        let now = Date()
        let todayHours = forecast[0].hour.filter {
            guard let date = $0.time.toDate() else { return false }
            return date > now
        }
        let nextDayHours = forecast.count > 1 ? forecast[1].hour : []
        return todayHours + nextDayHours
    }
}

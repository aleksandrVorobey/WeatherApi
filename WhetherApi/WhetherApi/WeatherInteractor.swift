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
                case .failure(let error):
                    self?.presenter?.weatherFetchFailed(with: error)
                }
            }
        }
    }
}

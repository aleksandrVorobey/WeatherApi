//
//  WeatherPresenter.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//


import Foundation

final class WeatherPresenter: WeatherPresenterProtocol {
    
    weak var view: WeatherViewProtocol?
    var interactor: WeatherInteractorInputProtocol
    var router: WeatherRouterProtocol
    
    private var location: LocationCoordinate?
    
    init(view: WeatherViewProtocol, interactor: WeatherInteractorInputProtocol, router: WeatherRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.showLoading()
        requestWeather()
    }
    
    func didTapRetry() {
        view?.showLoading()
        requestWeather()
    }
    
    private func requestWeather() {
        LocationManager.shared.getUserLocation { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let coordinate):
                self.location = coordinate
                self.interactor.fetchWeather(for: coordinate)
            case .failure(let error):
                self.view?.hideLoading()
                self.view?.showError("Не удалось получить локацию: \(error.localizedDescription)")
            }
        }
    }
    
}

extension WeatherPresenter: WeatherInteractorOutputProtocol {
    func weatherFetchSuccess(data: WeatherResponseData) {
        view?.hideLoading()
        let hourly = interactor.filterHourlyData(from: data.forecast.forecastday)
        view?.showWeather(data: data, hourly: hourly)
    }
    
    func weatherFetchFailed() {
        view?.hideLoading()
        view?.showError("Не удалось загрузить погоду. Попробуйте еще раз.")
    }
}

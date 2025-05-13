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
            
            let coordinate: LocationCoordinate
            switch result {
            case .success(let loc):
                coordinate = loc
            case .failure:
                coordinate = LocationCoordinate(latitude: 55.7558, longitude: 37.6173)
            }
            self.location = coordinate
            self.interactor.fetchWeather(for: coordinate)
        }
    }
}

// MARK: - WeatherInteractorOutputProtocol

extension WeatherPresenter: WeatherInteractorOutputProtocol {
    func weatherFetchSuccess(data: WeatherResponseData) {
        view?.hideLoading()
        view?.showWeather(data: data)
    }
    
    func weatherFetchFailed(with error: Error) {
        view?.hideLoading()
        view?.showError("Не удалось загрузить погоду. Попробуйте еще раз.")
    }
}

//
//  WeatherViewProtocol.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//


protocol WeatherViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
//    func showWeather(data: CurrentWeather, hourly: [HourWeather], daily: [ForecastDay])
    func showWeather(data: WeatherResponseData)
    func showError(_ message: String)
}

//
//  WeatherInteractorOutputProtocol.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//


protocol WeatherInteractorOutputProtocol: AnyObject {
    func weatherFetchSuccess(data: WeatherResponseData)
    func weatherFetchFailed(with error: Error)
}

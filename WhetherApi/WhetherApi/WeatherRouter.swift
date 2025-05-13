//
//  WeatherRouter.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//


import UIKit

final class WeatherRouter: WeatherRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = WeatherViewController()
        let service = NetworkService()
        let interactor = WeatherInteractor(networkService: service)
        let router = WeatherRouter()
        let presenter = WeatherPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

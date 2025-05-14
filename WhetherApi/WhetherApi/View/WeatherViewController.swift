//
//  WeatherViewController.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    var presenter: WeatherPresenterProtocol?
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    private let tableView = UITableView()
    
    private var allWeather: WeatherResponseData?
    private var hourly: [HourWeather] = []
    private var daily: [ForecastDay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 1.0, alpha: 1.0)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
        
        retryButton.setTitle("Повторить", for: .normal)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.isHidden = true
        view.addSubview(retryButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: CurrentWeatherCell.identifier)
        tableView.register(HourlyForecastRowCell.self, forCellReuseIdentifier: HourlyForecastRowCell.identifier)
        tableView.register(DailyForecastCell.self, forCellReuseIdentifier: DailyForecastCell.identifier)
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            errorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 12),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func retryTapped() {
        presenter?.didTapRetry()
    }
}

extension WeatherViewController: WeatherViewProtocol {
    func showLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
        errorLabel.isHidden = true
        retryButton.isHidden = true
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        retryButton.isHidden = false
        tableView.isHidden = true
    }
    
    func showWeather(data: WeatherResponseData, hourly: [HourWeather]) {
        self.allWeather = data
        self.hourly = hourly
        self.daily = data.forecast.forecastday
        tableView.isHidden = false
        errorLabel.isHidden = true
        retryButton.isHidden = true
        tableView.reloadData()
    }
    
}

extension WeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return daily.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherCell.identifier, for: indexPath) as! CurrentWeatherCell
            if let data = allWeather {
                cell.configure(with: data)
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyForecastRowCell.identifier, for: indexPath) as! HourlyForecastRowCell
            cell.configure(with: hourly)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastCell.identifier, for: indexPath) as! DailyForecastCell
            let forecast = daily[indexPath.row]
            cell.configure(with: forecast)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 120
        case 2:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
}

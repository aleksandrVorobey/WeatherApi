//
//  WeatherViewController.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    var presenter: WeatherPresenterProtocol!
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    private let tableView = UITableView()
    
    private var currentWeather: WeatherResponseData?
    private var hourly: [HourWeather] = []
    private var daily: [ForecastDay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
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
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
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
        presenter.didTapRetry()
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
    
    func showWeather(data: WeatherResponseData) {
        self.currentWeather = data
        self.hourly = data.forecast.forecastday[0].hour
        self.daily = data.forecast.forecastday
        tableView.isHidden = false
        errorLabel.isHidden = true
        retryButton.isHidden = true
        tableView.reloadData()
    }
}

extension WeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // current, hourly, daily
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return currentWeather != nil ? 1 : 0
        case 1: return hourly.count
        case 2: return daily.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        switch indexPath.section {
        case 0:
            if let weather = currentWeather {
                cell.configure(with: "Сейчас: \(weather.current.tempC)°C, \(weather.location.name)")
            }
        case 1:
            let hour = hourly[indexPath.row]
            cell.configure(with: "\(hour.time): \(hour.temp_c)°C, \(hour.condition.text)")
        case 2:
            let day = daily[indexPath.row]
            cell.configure(with: "\(day.date_epoch): \(day.day.mintemp_c)°C – \(day.day.maxtemp_c)°C")
        default:
            break
        }
        return cell
    }
}

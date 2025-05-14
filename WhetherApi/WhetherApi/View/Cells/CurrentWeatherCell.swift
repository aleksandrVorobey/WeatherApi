//
//  CurrentWeatherCell.swift
//  WhetherApi
//
//  Created by Александр Воробей on 14.05.2025.
//
import UIKit
import Kingfisher

final class CurrentWeatherCell: UITableViewCell {
    static let identifier = "CurrentWeatherCell"
    private let cityLabel = UILabel()
    private let tempLabel = UILabel()
    private let conditionImage = UIImageView()
    private let humidityLabel = UILabel()
    
    private let stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear


        cityLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        cityLabel.textAlignment = .center

        tempLabel.font = UIFont.systemFont(ofSize: 72, weight: .thin)
        tempLabel.textAlignment = .center

        humidityLabel.font = UIFont.systemFont(ofSize: 16)
        humidityLabel.textAlignment = .center

        conditionImage.contentMode = .scaleAspectFit
        conditionImage.heightAnchor.constraint(equalToConstant: 50).isActive = true

        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        [cityLabel, tempLabel, conditionImage, humidityLabel].forEach {
            stackView.addArrangedSubview($0)
        }

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with data: WeatherResponseData) {
        cityLabel.text = data.location.name
        tempLabel.text = "\(Int(data.current.tempC))°C"
        humidityLabel.text = "Влажность: \(data.current.humidity)%"
        conditionImage.kf.setImage(with: URL(string: "https:\(data.current.condition.icon)"), placeholder: UIImage(systemName: "cloud"))
    }
}

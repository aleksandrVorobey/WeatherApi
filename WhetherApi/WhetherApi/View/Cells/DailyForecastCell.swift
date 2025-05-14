//
//  DailyForecastCell.swift
//  WhetherApi
//
//  Created by Александр Воробей on 14.05.2025.
//

import UIKit
import Kingfisher

class DailyForecastCell: UITableViewCell {
    static let identifier = "DailyForecastCell"
    private let dayLabel = UILabel()
    private let iconImage = UIImageView()
    private let tempLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        [dayLabel, iconImage, tempLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        iconImage.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            iconImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 30),
            iconImage.heightAnchor.constraint(equalToConstant: 30),
            
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with forecast: ForecastDay) {
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dateEpoch))
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EEEE" 
        dayLabel.text = formatter.string(from: date).capitalized
        iconImage.kf.setImage(with: URL(string: "https:\(forecast.day.condition.icon)"), placeholder: UIImage(systemName: "cloud"))
        tempLabel.text = "\(Int(forecast.day.mintempC))° / \(Int(forecast.day.maxtempC))°"
    }
}

//
//  HourlyForecastCell.swift
//  WhetherApi
//
//  Created by Александр Воробей on 14.05.2025.
//

import UIKit
import Kingfisher

final class HourlyForecastCell: UICollectionViewCell {
    static let identifier = "HourlyForecastCell"

    private let timeLabel = UILabel()
    private let iconView = UIImageView()
    private let tempLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.3)
        contentView.clipsToBounds = true

        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textAlignment = .center

        iconView.contentMode = .scaleAspectFit
        iconView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        tempLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tempLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [timeLabel, iconView, tempLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    func configure(with model: HourWeather) {
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd HH:mm"
        if let hourDate = date.date(from: model.time) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "HH"
            timeLabel.text = hourFormatter.string(from: hourDate)
        } else {
            timeLabel.text = "—"
        }

        iconView.kf.setImage(with: URL(string: "https:\(model.condition.icon)"), placeholder: UIImage(systemName: "cloud"))
        tempLabel.text = "\(Int(model.tempC))°"
    }
}

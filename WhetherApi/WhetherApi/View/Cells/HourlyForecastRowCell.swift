//
//  HourlyForecastRowCell.swift
//  WhetherApi
//
//  Created by Александр Воробей on 14.05.2025.
//


import UIKit

final class HourlyForecastRowCell: UITableViewCell {
    static let identifier = "HourlyForecastRowCell"

    private var hours: [HourWeather] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 60, height: 100)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 1.0, alpha: 1.0)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HourlyForecastCell.self, forCellWithReuseIdentifier: HourlyForecastCell.identifier)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with hours: [HourWeather]) {
        self.hours = hours
        collectionView.reloadData()
    }
}

extension HourlyForecastRowCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hours.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCell.identifier, for: indexPath) as! HourlyForecastCell
        cell.configure(with: hours[indexPath.item])
        return cell
    }
}

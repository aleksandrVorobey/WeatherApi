//
//  String+Date.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//

import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd HH:mm") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        return formatter.date(from: self)
    }
}


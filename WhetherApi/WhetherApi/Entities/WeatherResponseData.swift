//
//  WeatherResponseData.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//

import Foundation

struct WeatherResponseData: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
}

struct CurrentWeather: Codable {
    let tempC: Double
    let condition: Condition
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case humidity
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}


struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let dateEpoch: Int
    let day: DayWeather
    let hour: [HourWeather]
    
    enum CodingKeys: String, CodingKey {
        case dateEpoch = "date_epoch"
        case day
        case hour
    }
}

struct DayWeather: Codable {
    let maxtempC: Double
    let mintempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}

struct HourWeather: Codable {
    let time: String
    let tempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}

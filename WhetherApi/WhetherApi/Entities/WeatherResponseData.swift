//
//  WeatherResponseData.swift
//  WhetherApi
//
//  Created by Александр Воробей on 13.05.2025.
//

import Foundation

struct WeatherResponseData: Decodable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}

struct CurrentWeather: Decodable {
    let tempC: Double
    let condition: Condition
    let windKph: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
        case humidity
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}


struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable {
//    let date: String
    let date_epoch: Int
    let day: DayWeather
    let astro: Astro
    let hour: [HourWeather]
}

struct DayWeather: Decodable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let avgtemp_c: Double
    let maxwind_kph: Double
    let totalprecip_mm: Double
    let totalsnow_cm: Double
    let avgvis_km: Double
//    let avghumidity: Double
//    let daily_will_it_rain: Int // 1 = Yes, 0 = No
    let daily_chance_of_rain: Int
//    let daily_will_it_snow: Int // 1 = Yes, 0 = No
//    let daily_chance_of_snow: Int
    let condition: Condition
}

struct Astro: Decodable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moon_phase: String
    let moon_illumination: Int
    let is_moon_up: Int
    let is_sun_up: Int
}

struct HourWeather: Decodable {
    let time_epoch: Int
    let time: String
    let temp_c: Double
    let temp_f: Double
    let is_day: Int
    let condition: Condition
    let wind_mph: Double
    let wind_kph: Double
    let wind_degree: Int
    let wind_dir: String
    let pressure_mb: Double
    let pressure_in: Double
    let precip_mm: Double
    let precip_in: Double
    let snow_cm: Double
    let humidity: Int
    let cloud: Int
    let feelslike_c: Double
    let feelslike_f: Double
    let windchill_c: Double
    let windchill_f: Double
    let heatindex_c: Double
    let heatindex_f: Double
    let dewpoint_c: Double
    let dewpoint_f: Double
    let will_it_rain: Int
    let chance_of_rain: Int
    let will_it_snow: Int
    let chance_of_snow: Int
    let vis_km: Double
    let vis_miles: Double
    let gust_mph: Double
    let gust_kph: Double
    let uv: Double
}

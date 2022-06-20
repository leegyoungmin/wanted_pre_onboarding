//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by 이경민 on 2022/06/20.
//

import Foundation

struct WeatherModel:Codable{
    let weathers:[weather]
    let main:Main
    let wind:wind
    
    enum CodingKeys:String,CodingKey{
        case weathers = "weather"
        case main
        case wind
    }
}

struct Main:Codable{
    let temp:Double
    let feels:Double
    let maxTemp:Double
    let minTemp:Double
    let pressure:Int
    let humidity:Int
    enum CodingKeys:String,CodingKey{
        case temp
        case feels = "feels_like"
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
        case pressure,humidity
    }
}

struct weather: Codable {
    let id: Int
    let main, weatherDescription:String
    var icon: String
    var weatherCondition:weatherCondition = .clear

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct wind:Codable{
    let speed:Double
    let degree:Int
    
    enum CodingKeys:String,CodingKey{
        case speed
        case degree = "deg"
    }
}

enum weatherCondition{
    case clear
    case cloud
    case rain
    case thunder
    case snow
    case mist
}

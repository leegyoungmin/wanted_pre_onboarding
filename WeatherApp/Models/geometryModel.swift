//
//  geometryModel.swift
//  WeatherApp
//
//  Created by 이경민 on 2022/06/20.
//

import Foundation

struct geometry:Codable{
    let id:Int
    let name:String
    let korName:String
    let country:String
    let coord:Coord
    
    enum CodingKeys:String,CodingKey{
        case id
        case name
        case korName = "name_kr"
        case country
        case coord
    }
}
struct Coord:Codable{
    let lon,lat:Double
}

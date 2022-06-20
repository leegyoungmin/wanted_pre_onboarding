//
//  WeatherApiService.swift
//  WeatherApp
//
//  Created by 이경민 on 2022/06/20.
//

import Foundation

class WeatherApiService{
    static let shared = WeatherApiService()
    
    var weatherList:[WeatherModel] = []
    let session = URLSession(configuration: .default)
    var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
    
    func load(_ geoId:Int,completion:@escaping(WeatherModel)->Void){
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else{return}
        urlComponents?.query = "id=\(geoId)&appid=\(apiKey)&lang=kr"
        
        guard let requestURL = urlComponents?.url else{return}
        URLSession.shared.dataTask(with: requestURL) { data, res, err in
            guard err == nil else{return}
            
            let successCodeRange = 200..<300
            guard let statusCode = (res as? HTTPURLResponse)?.statusCode,
                  successCodeRange.contains(statusCode) else{return}
            
            guard let result = data else{return}
            
            do{
                let decoder = JSONDecoder()
                let currentWeather = try decoder.decode(WeatherModel.self, from: result)
                self.weatherList.append(currentWeather)
                completion(currentWeather)
            } catch let decodeErr{
                print("fail in decode \(decodeErr)")
            }
        }
        .resume()
    }
}

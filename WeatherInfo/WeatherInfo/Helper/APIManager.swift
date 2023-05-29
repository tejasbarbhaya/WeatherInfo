//
//  APIManager.swift
//  MVVMDemo
//
//  Created by Tejash Barbhaya on 25/05/23.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    func getWeatherInformationForLatitude(_ latitude:String,_ longitude:String,_ complition:@escaping (Result<WeatherModel,Error>)->()) {
        let urlValue = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        let urlObj = URL(string: urlValue)
        let urlRequest = URLRequest(url: urlObj!)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                complition(.failure(error!))
                return
            }
            do {
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                complition(.success(weather))
            }catch {
                complition(.failure(error))
            }
        }.resume()
    }
}

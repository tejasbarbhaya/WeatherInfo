//
//  WeatherViewModel.swift
//  WeatherInfo
//
//  Created by Tejash Barbhaya on 26/05/23.
//

import Foundation

enum Event {
    case dataLoaded
    case dataFailure(Error?)
}

class WeatherViewModel {
    var weather:WeatherModel?
    var eventHandler:((_ event:Event) -> Void)?
    
    func getWeather(_ latitude:String, _ longitude:String) {
        APIManager.shared.getWeatherInformationForLatitude(latitude, longitude) { responses in
            switch responses {
            case .success(let weather):
                self.weather = weather
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.dataFailure(error))
            }
        }
    }
}

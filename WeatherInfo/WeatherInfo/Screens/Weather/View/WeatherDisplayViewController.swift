//
//  WeatherDisplayViewController.swift
//  WeatherInfo
//
//  Created by Tejash Barbhaya on 26/05/23.
//

import Foundation
import UIKit

class WeatherDisplayViewController :UIViewController {
    @IBOutlet weak var txtWeatherDetails:UITextView!
    
    var latitude:String?
    var longitude:String?
    var selectedWeatherType:WeatherType = .WeatherForLocation
    
    var viewModel:WeatherViewModel? = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuration()
    }
    
    func configuration() {
        initialization()
        observeNetworkResponse()
    }
    
    func initialization() {
        self.title = selectedWeatherType.rawValue
        viewModel?.getWeather(latitude!, longitude!)
    }
    
    func observeNetworkResponse() {
        viewModel?.eventHandler = { [weak self] resultEvent in
            guard let self else {return}
            switch resultEvent {
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.setUIValue(self.selectedWeatherType)
                }
                break
            case .dataFailure(let eror):
                self.showErrorMessage("Error", eror.debugDescription.description)
                break
            }
        }
    }
    
    func setUIValue(_ selectedWeatherType:WeatherType) {
        var finalWeatherValue = ""
        switch selectedWeatherType {
        case .WeatherForLocation:
            finalWeatherValue = "The Weather description is as below: \n id : \(viewModel?.weather?.weather?.first?.id! ?? 0) \n Descriptiion: \(viewModel?.weather?.weather?.first?.description! ?? "")"
            break
        case .WindForLocation:
            finalWeatherValue = "The Wind description is as below: \n speed : \(viewModel?.weather?.wind?.speed! ?? 0) \n Degree: \(viewModel?.weather?.wind?.deg! ?? 0)"
            break
        case .TempratureForLocation:
            let tempF = (viewModel?.weather?.main?.temp!)!
            let tempC = (tempF - 32) * (5/9)
            finalWeatherValue = "The Temparature description is as below: \n Temprature (f) : \(tempF) \n Temprature (c) : \(tempC)"
            break
        case .WeatherForLocationOnTimeFrame:
            finalWeatherValue = "The Weather description is as below: \n id : \(viewModel?.weather?.weather?.first?.id! ?? 0) \n Descriptiion: \(viewModel?.weather?.weather?.first?.description! ?? "")"
            break
        }
        self.txtWeatherDetails.text = finalWeatherValue
    }
    
    func jsonToString(json: WeatherModel?) -> String {
        do {
            let jsonData = try JSONEncoder().encode(json)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            return jsonString
        } catch let myJSONError {
            print(myJSONError)
        }
        return ""
    }
}



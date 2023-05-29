//
//  DashboardViewController.swift
//  WeatherInfo
//
//  Created by Tejash Barbhaya on 26/05/23.
//

import Foundation
import UIKit

enum WeatherType : String {
    case WeatherForLocation = "Test Current Weather for given location"
    case WindForLocation = "Test Current Wind for given location"
    case TempratureForLocation = "Test Current Temprature in (F/C) for given location"
    case WeatherForLocationOnTimeFrame = "Test Current Weather for future timeframe"
    
    static var allCases: [WeatherType] = [.WeatherForLocation, .WindForLocation,.TempratureForLocation,.WeatherForLocationOnTimeFrame]
}

class DashboardViewController : UIViewController {
    
    @IBOutlet weak var tblView:UITableView!
    
    @IBOutlet weak var txtLatitude:UITextField!
    @IBOutlet weak var txtLongitude:UITextField!
    
    let reusableCellId = "DashboardCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    func initializeViews() {
        tblView.register(UINib.init(nibName: "DashboardCellTableViewCell", bundle: .main), forCellReuseIdentifier: reusableCellId)
        tblView.delegate = self
        tblView.dataSource = self
        
        txtLatitude.delegate = self
        txtLongitude.delegate = self
        
        txtLatitude.text = "22"
        txtLongitude.text = "70"
    }
}

extension DashboardViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: reusableCellId) as! DashboardCellTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.lblText.text = WeatherType.WeatherForLocation.rawValue
        case 1:
            cell.lblText.text = WeatherType.WindForLocation.rawValue
        case 2:
            cell.lblText.text = WeatherType.TempratureForLocation.rawValue
        case 3:
            cell.lblText.text = WeatherType.WeatherForLocationOnTimeFrame.rawValue
        default:
            cell.lblText.text = "Unknown Cell Type"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

extension DashboardViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let lat = txtLatitude.text, lat != "" else {
            print("\n latitude value is not correct")
            showErrorMessage("Information", "Please enter valid latitude")
            return
        }
        
        guard let long = txtLongitude.text, long != "" else {
            print("\n longitude value is not correct")
            showErrorMessage("Information", "Please enter valid longitude")
            return
        }
        
        let weatherVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherVCId") as! WeatherDisplayViewController
                
        weatherVC.latitude = lat.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        weatherVC.longitude = long.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        switch indexPath.row {
        case 0:
            weatherVC.selectedWeatherType = .WeatherForLocation
            break
        case 1:
            weatherVC.selectedWeatherType = .WindForLocation
            break
        case 2:
            weatherVC.selectedWeatherType = .TempratureForLocation
            break
        case 3:
            weatherVC.selectedWeatherType = .WeatherForLocationOnTimeFrame
            break
        default:
            weatherVC.selectedWeatherType = .WindForLocation
        }
        self.navigationController?.pushViewController(weatherVC, animated: true)
    }
}

extension DashboardViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textValue = NSString(string: textField.text!).replacingCharacters(in: range, with: string).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if textField == txtLatitude, textValue != "" {
            if textValue.isValidLatitudeCheck() {
                return true
            }else {
                return false
            }
        }else if textField == txtLongitude, textValue != "" {
            if textValue.isValidLongitudeCheck() {
                return true
            }else {
                return false
            }
        }
        return true
    }
}

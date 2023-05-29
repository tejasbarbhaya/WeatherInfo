//
//  Utilities.swift
//  WeatherInfo
//
//  Created by Tejash Barbhaya on 26/05/23.
//

import Foundation
import UIKit

let apiKey = ""
extension String {
    func isValidLatitudeCheck() -> Bool {
        let passwordRegex = "^-?([0-8]?[0-9]|90)(\\.[0-9]{1,10})?$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    func isValidLongitudeCheck() -> Bool {
        let passwordRegex = "^-?([0-9]{1,2}|1[0-7][0-9]|180)(\\.[0-9]{1,10})?$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}

extension UIViewController {
    func showErrorMessage(_ title:String , _ errorMessage : String) {
        let alertController = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

//
//  Alerts.swift
//  Cars
//
//  Created by Tatia on 22.03.21.
//

import Foundation
import UIKit

class myAlert {
    static func showAlert(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

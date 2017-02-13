//
//  AlertsProtocolWithExt.swift
//  UltraZvuk
//
//  Created by Petr Stenin on 12/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(forVC VC: UIViewController, withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        VC.present(alert, animated: true, completion: nil)
    }

}

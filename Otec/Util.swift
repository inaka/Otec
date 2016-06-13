//
//  Util.swift
//  Otec
//
//  Created by El gera de la gente on 6/8/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import UIKit
import IKEventSource

struct Util {
    static func showAlertWithTitle(title: String, message: String, onViewController viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .Cancel) { (action) in
            alertController.dismissViewControllerAnimated(false, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
}
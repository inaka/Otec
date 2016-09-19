//
//  UIViewController+ErrorAlert.swift
//  Otec
//
//  Created by El gera de la gente on 6/8/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertWithTitle(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

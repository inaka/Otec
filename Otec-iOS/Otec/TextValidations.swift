//
//  TextValidations.swift
//  Otec
//
//  Created by El gera de la gente on 6/3/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation
import UIKit

protocol TextValidable {
    var hasValidText: Bool {get}
}

extension UITextField: TextValidable {
    var hasValidText: Bool {
        guard let text = self.text else { return false }
        
        if text == "" { return false }

        return true
    }
}

extension UITextView: TextValidable {
    var hasValidText: Bool {
        if self.text == "" { return false }
        
        return true
    }
}
//
//  UserNewspaperSession.swift
//  Otec
//
//  Created by El gera de la gente on 6/6/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import Foundation

struct UserNewspaperSession {
    
    static func isUserLoggedIn() -> Bool {
        return NSUserDefaults.standardUserDefaults().objectForKey(Constants.newspaperUserDefaultsKey) != nil
    }
    
    static func userNewspaperName() -> String {
        return NSUserDefaults.standardUserDefaults().objectForKey(Constants.newspaperUserDefaultsKey) as! String
    }
    
    static func saveUserNewspaper(newspaperName: String) {
        NSUserDefaults.standardUserDefaults().setObject(newspaperName, forKey:Constants.newspaperUserDefaultsKey)
    }
}
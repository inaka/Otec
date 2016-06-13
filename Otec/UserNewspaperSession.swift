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
    
    static func deleteUserNewspaper() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.newspaperUserDefaultsKey)
    }
    
    static func newspapersSuscribed() -> [String] {
        
        let suscriptions = NSUserDefaults.standardUserDefaults().objectForKey(Constants.newspapersSuscribedDefaultsKey) as? [String] ?? [String]()
        
        return suscriptions
    }
    
    static func saveNewspapersSuscription(newspapersSuscribed: [String]) {
        NSUserDefaults.standardUserDefaults().setObject(newspapersSuscribed, forKey:Constants.newspapersSuscribedDefaultsKey)
    }
    
}
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
        return NSUserDefaults.standardUserDefaults().objectForKey(Constants.NewspaperUserDefaultsKey) != nil
    }
    
    static func userNewspaperName() -> String {
        return NSUserDefaults.standardUserDefaults().objectForKey(Constants.NewspaperUserDefaultsKey) as! String
    }
    
    static func saveUserNewspaper(newspaperName: String) {
        NSUserDefaults.standardUserDefaults().setObject(newspaperName, forKey:Constants.NewspaperUserDefaultsKey)
    }
    
    static func deleteUserNewspaper() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.NewspaperUserDefaultsKey)
    }
    
    static func newspapersSuscribed() -> [String] {
        
        let suscriptions = NSUserDefaults.standardUserDefaults().objectForKey(Constants.NewspapersSuscribedDefaultsKey) as? [String] ?? [String]()
        
        return suscriptions
    }
    
    static func saveNewspapersSuscription(newspapersSuscribed: [String]) {
        NSUserDefaults.standardUserDefaults().setObject(newspapersSuscribed, forKey:Constants.NewspapersSuscribedDefaultsKey)
    }
    
}
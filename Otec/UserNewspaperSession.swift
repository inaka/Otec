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
    
    static func newspapersSubscribed() -> [String] {
        
        let subscriptions = NSUserDefaults.standardUserDefaults().objectForKey(Constants.NewspapersSubscribedDefaultsKey) as? [String] ?? [String]()
        
        return subscriptions
    }
    
    static func saveNewspapersSubscription(newspapersSubscribed: [String]) {
        NSUserDefaults.standardUserDefaults().setObject(newspapersSubscribed, forKey:Constants.NewspapersSubscribedDefaultsKey)
    }
    
}
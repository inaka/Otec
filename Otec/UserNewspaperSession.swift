//
//  UserNewspaperSession.swift
//  Otec
//
// Copyright (c) 2016 Inaka - http://inaka.net/
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


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
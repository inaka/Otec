//
//  NewsFeedViewController.swift
//  Otec
//
//  Created by El gera de la gente on 5/11/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit
import Jayme
class NewsFeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoutButton = UIBarButtonItem(title: "< Logout", style: .Plain, target: self, action:#selector(logout))
        self.navigationItem.leftBarButtonItem = logoutButton
        
    }
    func logout(sender: AnyObject) {
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userNewspaperID")
            self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}


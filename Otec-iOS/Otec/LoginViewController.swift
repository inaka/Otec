    //
//  LoginViewController.swift
//  Otec
//
//  Created by El gera de la gente on 5/11/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var newspaperTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkIfLoggedInThenShowFeed()
    }

    private func checkIfLoggedInThenShowFeed() {
        if (NSUserDefaults.standardUserDefaults().objectForKey("userNewspaperID") != nil) {
            self.pushFeedsViewController(animated: false)
        }
    }
    
    private func pushFeedsViewController(animated animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("NewsFeedViewController") as! NewsFeedViewController
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @IBAction func login(sender: AnyObject) {
        let newspaperName = newspaperTextfield.text!
        
        let future = NewspaperRepository().findByID(newspaperName)
        future.start() { result in
            switch result {
            case .Success(let newspaper):
                dispatch_async(dispatch_get_main_queue()) {
                    NSUserDefaults.standardUserDefaults().setObject(newspaper.id, forKey:"userNewspaperID")
                    self.pushFeedsViewController(animated: true)
                }
            case .Failure(let error):
                print ("error : \(error)")
            }
        }
    }

    @IBAction func loginAsGuestUser(sender: AnyObject) {
        self.pushFeedsViewController(animated: true)
    }
    
}

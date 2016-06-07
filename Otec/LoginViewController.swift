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
        if (UserNewspaperSession.isUserLoggedIn()) {
            self.pushFeedsViewController(animated: false)
        }
    }
    
    private func pushFeedsViewController(animated animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("NewsFeedViewController") as! NewsFeedViewController
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @IBAction func login(sender: UIButton) {
        if !self.checkFieldsEmptiness([self.newspaperTextfield]) {
            self.showAlertWithTitle("Error", message: "Newspaper name is requiered")
            return
        }
        
        let future = NewspaperRepository().findByID(newspaperTextfield.text!)
        future.start() { result in
            switch result {
            case .Success(let newspaper):
                dispatch_async(dispatch_get_main_queue()) {
                    UserNewspaperSession.saveUserNewspaper(newspaper.id)
                    self.pushFeedsViewController(animated: true)
                }
            case .Failure(_):
                dispatch_async(dispatch_get_main_queue()) {
                    self.showAlertWithTitle("Error", message: "Check your newspaper name and try again")
                }
            }
        }
    }

    @IBAction func loginAsGuestUser(sender: UIButton) {
        self.pushFeedsViewController(animated: true)
    }
 
    private func checkFieldsEmptiness(textInputs: [TextValidable]) -> Bool{
        var inputsAllValid = true
        
        textInputs.forEach { if !$0.hasValidText { inputsAllValid = false } }
        
        return inputsAllValid
    }
    
    private func showAlertWithTitle(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .Cancel) { (action) in
            alertController.dismissViewControllerAnimated(false, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

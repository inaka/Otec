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
    
    private func checkIfHasSuscriptions() -> Bool {
        return !UserNewspaperSession.newspapersSuscribed().isEmpty
    }
    
    private func pushSuscriptionsViewController(animated animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("NewspapersSubscriptionViewController") as! NewspapersSubscriptionViewController
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    private func pushFeedsViewController(animated animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("NewsFeedViewController") as! NewsFeedViewController
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @IBAction func login(sender: UIButton) {
        if !self.haveValidTexts([self.newspaperTextfield]) {
            self.showAlertWithTitle("Error", message: "Newspaper name is requiered")
            return
        }
        
        let future = NewspaperRepository().findByID(newspaperTextfield.text!)
        future.start() { result in
            switch result {
            case .Success(let newspaper):
                    UserNewspaperSession.saveUserNewspaper(newspaper.id)
                    if self.checkIfHasSuscriptions() {
                        self.pushFeedsViewController(animated: true)
                    }else {
                        self.pushSuscriptionsViewController(animated: true)
                    }
            case .Failure(_):
                    self.showAlertWithTitle("Error", message: "Check your newspaper name and try again")
            }
        }
    }

    @IBAction func loginAsGuestUser(sender: UIButton) {
        UserNewspaperSession.deleteUserNewspaper()
        if self.checkIfHasSuscriptions() {
            self.pushFeedsViewController(animated: true)
        }else {
            self.pushSuscriptionsViewController(animated: true)
        }
    }
 
    private func haveValidTexts(textInputs: [TextValidable]) -> Bool{
        var inputsAllValid = true
        
        textInputs.forEach { if !$0.hasValidText { inputsAllValid = false } }
        
        return inputsAllValid
    }
}

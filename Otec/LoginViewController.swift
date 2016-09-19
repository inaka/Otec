//
//  LoginViewController.swift
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

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var newspaperTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkIfLoggedInThenShowFeed()
    }

    fileprivate func checkIfLoggedInThenShowFeed() {
        if UserNewspaperSession.isUserLoggedIn() {
            self.pushFeedsViewController(animated: false)
        }
    }
    
    fileprivate func deviceHasSubscriptions() -> Bool {
        return !UserNewspaperSession.newspapersSubscribedIDs().isEmpty
    }
    
    fileprivate func pushSubscriptionsViewController(animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewspapersSubscriptionViewController") as! NewspapersSubscriptionViewController
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    fileprivate func pushFeedsViewController(animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsFeedViewController") as! NewsFeedViewController
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @IBAction func login(_ sender: UIButton) {
        if !self.haveValidTexts([self.newspaperTextfield]) {
            self.showAlertWithTitle("Error", message: "Newspaper name is requiered")
            return
        }
        
        let future = NewspaperRepository().find(byId: newspaperTextfield.text!)
        future.start() { result in
            switch result {
            case .success(let newspaper):
                    UserNewspaperSession.saveUserNewspaper(newspaper.id)
                    if self.deviceHasSubscriptions() {
                        self.pushFeedsViewController(animated: true)
                    }else {
                        self.pushSubscriptionsViewController(animated: true)
                    }
            case .failure(_):
                    self.showAlertWithTitle("Error", message: "Check your newspaper name and try again")
            }
        }
    }

    @IBAction func loginAsGuestUser(_ sender: UIButton) {
        UserNewspaperSession.deleteUserNewspaper()
        if self.deviceHasSubscriptions() {
            self.pushFeedsViewController(animated: true)
        }else {
            self.pushSubscriptionsViewController(animated: true)
        }
    }
 
    fileprivate func haveValidTexts(_ textInputs: [TextValidable]) -> Bool {
        var inputsAllValid = true
        
        textInputs.forEach { if !$0.hasValidText { inputsAllValid = false } }
        
        return inputsAllValid
    }
}

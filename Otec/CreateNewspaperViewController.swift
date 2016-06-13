//
//  CreateNewspaperViewController.swift
//  Otec
//
//  Created by El gera de la gente on 5/11/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class CreateNewspaperViewController: UIViewController {
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func pushFeedsViewController(animated animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("NewsFeedViewController") as! NewsFeedViewController
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @IBAction func createNewspaper(sender: UIBarButtonItem) {
        if !self.haveValidTexts([self.nameTextfield, self.descriptionTextView]) {
            self.showAlertWithTitle("Error", message: "Name and description are requiered.")
            print ("name or description cannot be empty")
            return
        }
        
        let newspaperDictionary = ["name":self.nameTextfield.text!,
                                   "description":self.descriptionTextView.text!]
        
        guard let newspaper = try? Newspaper(dictionary:newspaperDictionary) else {
            self.showAlertWithTitle("Error", message: "Error creating the newspaper.")
            return
        }
        let future = NewspaperRepository().create(newspaper)
        future.start() { result in
            switch result {
            case .Success(let newspaper):
                    UserNewspaperSession.saveUserNewspaper(newspaper.id)
                    self.pushFeedsViewController(animated: true)
            case .Failure(_):
                    Util.showAlertWithTitle("Error", message: "A server error happened.", onViewController:self)
            }
        }
    }
    
    private func haveValidTexts(textInputs: [TextValidable]) -> Bool{
        var inputsAllValid = true
        
        textInputs.forEach {
            print ("text \($0.hasValidText)")
            if !$0.hasValidText { inputsAllValid = false }
        }
        
        return inputsAllValid
    }
    
}

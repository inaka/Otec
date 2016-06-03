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
        if !self.checkFieldsEmptiness([self.nameTextfield, self.descriptionTextView]) {
            print ("name or description cannot be empty")
            return
        }
        
        let newspaperDictionary = ["name":self.nameTextfield.text!,
                                   "description":self.descriptionTextView.text!]
        
        guard let newspaper = try? Newspaper(dictionary:newspaperDictionary) else {
            print("error")
            return
        }
        let future = NewspaperRepository().create(newspaper)
        future.start() { result in
            switch result {
            case .Success(let newspaper):
                dispatch_async(dispatch_get_main_queue()) {
                    NSUserDefaults.standardUserDefaults().setObject(newspaper.id, forKey:Constants.newspaperUserDefaultsKey)
                    self.pushFeedsViewController(animated: true)
                }
            case .Failure(let error):
                print ("error : \(error)")
            }
        }
    }
    
    private func checkFieldsEmptiness(textInputs: [TextValidable]) -> Bool{
        var inputsAllValid = true
        
        textInputs.forEach {
            print ("text \($0.hasValidText)")
            if !$0.hasValidText { inputsAllValid = false }
        }
        
        return inputsAllValid
    }
    
}

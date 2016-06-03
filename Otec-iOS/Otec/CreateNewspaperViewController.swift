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

        let createButton = UIBarButtonItem(title: "Create", style: .Plain, target: self, action:#selector(createNewspaper))
        self.navigationItem.rightBarButtonItem = createButton
    }
    
    private func pushFeedsViewController(animated animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("NewsFeedViewController") as! NewsFeedViewController
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func createNewspaper(sender: AnyObject) {
        if !self.checkFieldsEmptiness(self.nameTextfield, descriptionTextView: self.descriptionTextView) {
            print ("name or description cannot be empty")
            return
        }
        
        let newspaperDictionary = ["name":self.nameTextfield.text!,
                                   "description":self.descriptionTextView.text!]
        
        guard let newspaper = try? Newspaper.init(dictionary:newspaperDictionary) else {
            print("error")
            return
        }
        let future = NewspaperRepository().create(newspaper)
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
    
    private func checkFieldsEmptiness(nameTextfield: UITextField, descriptionTextView: UITextView) -> Bool{
        guard let name = nameTextfield.text,
            let description = descriptionTextView.text else {
                return false
        }
        
        if name == "" || description == "" {
            return false
        }
        return true
    }
    
}

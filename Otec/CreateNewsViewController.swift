//
//  CreateNewsViewController.swift
//  Otec
//
//  Created by El gera de la gente on 6/8/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class CreateNewsViewController: UIViewController {

    @IBOutlet weak var newNameTextfield: UITextField!
    @IBOutlet weak var newBodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createNew(sender: UIBarButtonItem) {
        if !self.checkFieldsEmptiness([self.newNameTextfield, self.newBodyTextView]) {
            print ("name or description cannot be empty")
            return
        }
        
        let newDictionary = ["title":self.newNameTextfield.text!,
                                   "body":self.newBodyTextView.text!,
                                   "id":"temp-id",
                                   "newspaper_name":UserNewspaperSession.userNewspaperName()]
        
        guard let new = try? News(dictionary:newDictionary) else {
            print("error")
            return
        }
        let future = NewsRepository().create(new)
        future.start() { result in
            switch result {
            case .Success(_):
                dispatch_async(dispatch_get_main_queue()) {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            case .Failure(let error):
                print ("error : \(error)")
            }
        }
    }
    
    private func checkFieldsEmptiness(textInputs: [TextValidable]) -> Bool{
        var inputsAllValid = true
        
        textInputs.forEach {
            if !$0.hasValidText { inputsAllValid = false }
        }
        
        return inputsAllValid
    }
    
}

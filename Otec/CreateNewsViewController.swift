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
        if !self.haveValidTexts([self.newNameTextfield, self.newBodyTextView]) {
            self.showAlertWithTitle("Error", message: "Title and body are requiered.")
            return
        }
        
        let newDictionary = ["title":self.newNameTextfield.text!,
                                   "body":self.newBodyTextView.text!,
                                   "id":"temp-id",
                                   "newspaper_name":UserNewspaperSession.userNewspaperName()]
        
        guard let new = try? News(dictionary:newDictionary) else {
            Util.showAlertWithTitle("Error", message: "Something went wrong with the server response.", onViewController:self)
            return
        }
        let future = NewsRepository().create(new)
        future.start() { result in
            switch result {
            case .Success(_):
                    self.navigationController?.popViewControllerAnimated(true)
            case .Failure(_):
                Util.showAlertWithTitle("Error", message: "A server error happened.", onViewController:self)
            }
        }
    }
    
    private func haveValidTexts(textInputs: [TextValidable]) -> Bool{
        var inputsAllValid = true
        
        textInputs.forEach {
            if !$0.hasValidText { inputsAllValid = false }
        }
        
        return inputsAllValid
    }
    
}

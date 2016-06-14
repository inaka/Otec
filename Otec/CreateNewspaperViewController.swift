//
//  CreateNewspaperViewController.swift
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
            if !$0.hasValidText { inputsAllValid = false }
        }
        
        return inputsAllValid
    }
}

//
//  CreateNewsViewController.swift
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

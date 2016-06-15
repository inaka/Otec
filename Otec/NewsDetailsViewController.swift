//
//  NewsDetailsViewController.swift
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

class NewsDetailsViewController: UIViewController {
    @IBOutlet weak var newspaperNameLabel: UILabel!
    @IBOutlet weak var newBodyTextView: UITextView!
    
    var new: News!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newspaperNameLabel.text = "by " + self.new.newspaper
        self.newBodyTextView.text = self.new.body
        self.title = self.new.title
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showNewspaperNewsList(_:)))
        self.newspaperNameLabel.userInteractionEnabled = true 
        self.newspaperNameLabel.addGestureRecognizer(tapRecognizer)
    }
    
    func showNewspaperNewsList(gesture: UITapGestureRecognizer) {
        let future = NewspaperRepository().findByID(self.new.newspaper)
        
        future.start { result in
            switch result {
            case .Success(let newspaper):
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewControllerWithIdentifier("newspaperNewsListViewController") as! NewspaperNewsListViewController
                viewController.newspaper = newspaper
                self.navigationController?.pushViewController(viewController, animated: true)
            case .Failure(_):
                self.showAlertWithTitle("Error", message: "A server error happened.")
            }
        }
    }


}

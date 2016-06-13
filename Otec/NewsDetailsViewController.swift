//
//  NewsDetailsViewController.swift
//  Otec
//
//  Created by El gera de la gente on 6/9/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

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
    }
}

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
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showNewspaperNewsList(_:)))
        self.newspaperNameLabel.userInteractionEnabled = true 
        self.newspaperNameLabel.addGestureRecognizer(tapRecognizer)
    }
    
    func showNewspaperNewsList(gesture: UITapGestureRecognizer) {
        let future = NewspaperRepository().findByID(UserNewspaperSession.userNewspaperName())
        
        future.start { result in
            switch result {
            case .Success(let newspaper):
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewControllerWithIdentifier("newspaperNewsListViewController") as! NewspaperNewsListViewController
                viewController.newspaper = newspaper
                self.navigationController?.pushViewController(viewController, animated: true)
            case .Failure(_):
                Util.showAlertWithTitle("Error", message: "A server error happened.", onViewController:self)
            }
        }
    }


}

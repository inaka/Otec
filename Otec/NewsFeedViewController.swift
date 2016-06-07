//
//  NewsFeedViewController.swift
//  Otec
//
//  Created by El gera de la gente on 5/11/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit
import Jayme
class NewsFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = NewsDataSource(news: [News]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retrieveNewsFromServer()
    }
    
    private func retrieveNewsFromServer() {
        //FIXME : Change this for SSE
        
        let future = NewsRepository().findAll()
        
        future.start() { result in
            switch result {
            case .Success(let news):
                dispatch_async(dispatch_get_main_queue()) {
                    let dataSource = NewsDataSource(news: news)
                    self.tableView.dataSource = dataSource
                    self.tableView.reloadData()
                }
            case .Failure(_):
                dispatch_async(dispatch_get_main_queue()) {
                    self.showAlertWithTitle("Error", message: "Check your newspaper name and try again")
                }
            }
        }

    }
    
    private func showAlertWithTitle(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .Cancel) { (action) in
            alertController.dismissViewControllerAnimated(false, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logout(sender: AnyObject) {
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userNewspaperID")
            self.navigationController?.popToRootViewControllerAnimated(true)
    }
}


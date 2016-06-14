//
//  NewsFeedViewController.swift
//  Otec
//
//  Created by El gera de la gente on 5/11/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit
import Jayme
class NewsFeedViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var news = [News]()
    var dataSource = NewsDataSource(news: [News]())
    let eventSource = NewsRepository().newsEventSource()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.retrieveNewsFromServer()
    }
    
    private func retrieveNewsFromServer() {
        NewsRepository().findNews(withEventSource: self.eventSource) { responseNew in
            guard let new = responseNew else { return }
            self.news.append(new)
            self.dataSource = NewsDataSource(news: self.news)
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    @IBAction func showUserOptions(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let pushSuscriptionsAction = UIAlertAction(title: "Subscriptions", style: .Default) { (action) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("NewspapersSubscriptionViewController") as! NewspapersSubscriptionViewController
            self.navigationController?.pushViewController(viewController, animated: true)
            alertController.dismissViewControllerAnimated(false, completion: nil)
        }
        alertController.addAction(pushSuscriptionsAction)
        
        
        if UserNewspaperSession.isUserLoggedIn() {
            let pushCreateNewsAction = UIAlertAction(title: "Create New", style: .Default) { (action) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewControllerWithIdentifier("createNewsViewController") as! CreateNewsViewController
                self.navigationController?.pushViewController(viewController, animated: true)
                alertController.dismissViewControllerAnimated(false, completion: nil)
            }
            alertController.addAction(pushCreateNewsAction)
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logout(sender: UIBarButtonItem) {
            UserNewspaperSession.deleteUserNewspaper()
            self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("newsDetailsViewController") as! NewsDetailsViewController
        viewController.new = self.news[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


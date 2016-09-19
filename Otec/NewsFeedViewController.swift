//
//  NewsFeedViewController.swift
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
import Jayme
class NewsFeedViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var news = [News]()
    var dataSource = NewsDataSource(news: [News]())
    let eventSource = NewsListener().newsEventSource()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.retrieveNewsFromServer()
    }
    
    fileprivate func retrieveNewsFromServer() {
        NewsListener().listenToNewsWithEventSource(self.eventSource, forNewspapersIDs: UserNewspaperSession.newspapersSubscribedIDs()) { responseNew in
            switch responseNew {
            case .failure(_):
                self.showAlertWithTitle("Error", message: "Server response corrupted.")
            case .success(let new):
                self.news.append(new)
                self.dataSource = NewsDataSource(news: self.news)
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func showUserOptions(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let pushSubscriptionsAction = UIAlertAction(title: "Subscriptions", style: .default) { (action) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "NewspapersSubscriptionViewController") as! NewspapersSubscriptionViewController
            self.navigationController?.pushViewController(viewController, animated: true)
            alertController.dismiss(animated: false, completion: nil)
        }
        alertController.addAction(pushSubscriptionsAction)
        
        
        if UserNewspaperSession.isUserLoggedIn() {
            let pushCreateNewsAction = UIAlertAction(title: "Create New", style: .default) { (action) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "createNewsViewController") as! CreateNewsViewController
                self.navigationController?.pushViewController(viewController, animated: true)
                alertController.dismiss(animated: false, completion: nil)
            }
            alertController.addAction(pushCreateNewsAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
            UserNewspaperSession.deleteUserNewspaper()
            let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "newsDetailsViewController") as! NewsDetailsViewController
        viewController.new = self.news[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

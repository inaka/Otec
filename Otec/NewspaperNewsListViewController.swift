//
//  NewspaperNewsListViewController.swift
//  Otec
//
//  Created by El gera de la gente on 6/13/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class NewspaperNewsListViewController: UIViewController, UITableViewDelegate {

    var dataSource = NewsDataSource(news: [News]())
    var newspaper: Newspaper!
    var news = [News]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveNewsFromServer()
    }
    
    private func retrieveNewsFromServer() {
        NewsListener().listenToNewsPaper(self.newspaper.id){ responseNew in
            switch responseNew {
            case .Failure(_):
                self.showAlertWithTitle("Error", message: "Server response corrupted.")
            case .Success(let new):
                self.news.append(new)
                self.dataSource = NewsDataSource(news: self.news)
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("newsDetailsViewController") as! NewsDetailsViewController
        viewController.new = self.dataSource.news[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

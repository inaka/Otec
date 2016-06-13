//
//  NewspapersSubscriptionViewController.swift
//  Otec
//
//  Created by El gera de la gente on 6/8/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class NewspapersSubscriptionViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var newspaperSuscriptedIDs = UserNewspaperSession.newspapersSuscribed()
    var allNewspapers = [Newspaper]()
    var dataSource = NewspaperSubscriptionDataSource(newspapers: [Newspaper](), newspaperSubscribedIDs: [String]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newspaperSuscriptedIDs = UserNewspaperSession.newspapersSuscribed()
        if self.checkIfComesFromFeed() {
           self.navigationItem.rightBarButtonItem = nil
        }

        self.retrieveAndShowAllNewspapers()
    }
    
    private func checkIfComesFromFeed() -> Bool {
        var comesFromFeed = false
        
        self.navigationController?.viewControllers.forEach{
            if $0.isKindOfClass(NewsFeedViewController) { comesFromFeed = true }
        }
        return comesFromFeed
    }
    
    private func retrieveAndShowAllNewspapers() {
        let future = NewspaperRepository().findAll()

        future.start() { result in
            switch result {
            case .Success(let newspapers):
                self.dataSource = NewspaperSubscriptionDataSource(newspapers: newspapers, newspaperSubscribedIDs: self.newspaperSuscriptedIDs)
                self.allNewspapers = newspapers
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            case .Failure(_):
                Util.showAlertWithTitle("Error", message: "Couldn't get the newspapers list. Go back and try again.", onViewController:self)
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let newspaper = self.allNewspapers[indexPath.row]
        
        if self.newspaperSuscriptedIDs.contains(newspaper.id) {
            self.newspaperSuscriptedIDs = self.newspaperSuscriptedIDs.filter { $0 != newspaper.id }
        }else {
            self.newspaperSuscriptedIDs.append(newspaper.id)
        }
        
        UserNewspaperSession.saveNewspapersSuscription(self.newspaperSuscriptedIDs)
        
        self.dataSource = NewspaperSubscriptionDataSource(newspapers: self.allNewspapers, newspaperSubscribedIDs: self.newspaperSuscriptedIDs)
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }
}

//
//  NewspapersSubscriptionViewController.swift
//  Otec
//
//  Created by El gera de la gente on 6/8/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class NewspapersSubscriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var newspaperSuscriptedIDs = UserNewspaperSession.newspapersSuscribed()
    var allNewspapers = [Newspaper]()
    
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
                dispatch_async(dispatch_get_main_queue()) {
                    self.allNewspapers = newspapers
                    self.tableView.reloadData()
                }
            case .Failure(_):
                dispatch_async(dispatch_get_main_queue()) {
                    Util.showAlertWithTitle("Error", message: "Couldn't get the newspapers list. Go back and try again.", onViewController:self)
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allNewspapers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newspaper = self.allNewspapers[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell") {
            cell.textLabel!.text = newspaper.id
            cell.accessoryType = self.newspaperSuscriptedIDs.contains(newspaper.id) ? .Checkmark : .None
            return cell
        }
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel!.text = newspaper.id
        cell.accessoryType = self.newspaperSuscriptedIDs.contains(newspaper.id) ? .Checkmark : .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let newspaper = self.allNewspapers[indexPath.row]
        
        if self.newspaperSuscriptedIDs.contains(newspaper.id) {
            self.newspaperSuscriptedIDs = self.newspaperSuscriptedIDs.filter { $0 != newspaper.id }
        }else {
            self.newspaperSuscriptedIDs.append(newspaper.id)
        }
        
        UserNewspaperSession.saveNewspapersSuscription(self.newspaperSuscriptedIDs)
        
        self.tableView.reloadData()
    }
}

//
//  NewspaperSubscriptionDataSource.swift
//  Otec
//
//  Created by El gera de la gente on 6/13/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class NewspaperSubscriptionDataSource: NSObject, UITableViewDataSource {

    private let newspapers: [Newspaper]
    private let newspapersSubscribedIDs: [String]
    
    init(newspapers: [Newspaper], newspaperSubscribedIDs subscriptionsIDs: [String]){
        self.newspapers = newspapers
        self.newspapersSubscribedIDs = subscriptionsIDs
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newspapers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newspaper = self.newspapers[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier(Constants.NewspapersSubscriptionCellIdentifier) as? NewspaperSubscriptionTableViewCell {
            cell.newspaper = newspaper
            cell.accessoryType = self.newspaperIsSubscribed(newspaper, newspapersSubscribedIDs: self.newspapersSubscribedIDs) ? .Checkmark : .None
            return cell
        }
        let cell = NSBundle.mainBundle().loadNibNamed(Constants.NewsFeedCellIdentifier, owner: self, options: nil).first as! NewspaperSubscriptionTableViewCell
        cell.newspaper = newspaper
        cell.accessoryType = self.newspaperIsSubscribed(newspaper, newspapersSubscribedIDs: self.newspapersSubscribedIDs) ? .Checkmark : .None        
        return cell
    }
    
    private func newspaperIsSubscribed(newspaper: Newspaper, newspapersSubscribedIDs subscriptionsIDs: [String]) -> Bool {
        return subscriptionsIDs.contains(newspaper.id)
    }
}

//
//  NewsDataSource.swift
//  Otec
//
//  Created by El gera de la gente on 6/6/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class NewsDataSource: NSObject, UITableViewDataSource {
    
    let news : [News]
    
    init(news: [News]){
        self.news = news
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(Constants.newsFeedCellIdentifier) as? NewsTableViewCell {
            cell.news = self.news[indexPath.row]
            return cell
        }
        let cell = NSBundle.mainBundle().loadNibNamed(Constants.newsFeedCellIdentifier, owner: self, options: nil).first as! NewsTableViewCell
        cell.news = self.news[indexPath.row]
        return cell
    }
    
}

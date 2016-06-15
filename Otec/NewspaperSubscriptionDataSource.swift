//
//  NewspaperSubscriptionDataSource.swift
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
        let cell = NSBundle.mainBundle().loadNibNamed(Constants.NewsFeedCellClassName, owner: self, options: nil).first as! NewspaperSubscriptionTableViewCell
        cell.newspaper = newspaper
        cell.accessoryType = self.newspaperIsSubscribed(newspaper, newspapersSubscribedIDs: self.newspapersSubscribedIDs) ? .Checkmark : .None        
        return cell
    }
    
    private func newspaperIsSubscribed(newspaper: Newspaper, newspapersSubscribedIDs subscriptionsIDs: [String]) -> Bool {
        return subscriptionsIDs.contains(newspaper.id)
    }
}

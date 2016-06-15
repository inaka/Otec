//
//  NewspapersSubscriptionViewController.swift
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

class NewspapersSubscriptionViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var newspaperSubscriptedIDs = UserNewspaperSession.newspapersSubscribed()
    var allNewspapers = [Newspaper]()
    var dataSource = NewspaperSubscriptionDataSource(newspapers: [Newspaper](), newspaperSubscribedIDs: [String]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newspaperSubscriptedIDs = UserNewspaperSession.newspapersSubscribed()
        if self.comesFromFeed() {
           self.navigationItem.rightBarButtonItem = nil
        }

        self.retrieveAndShowAllNewspapers()
    }
    
    private func comesFromFeed() -> Bool {
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
                self.dataSource = NewspaperSubscriptionDataSource(newspapers: newspapers, newspaperSubscribedIDs: self.newspaperSubscriptedIDs)
                self.allNewspapers = newspapers
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            case .Failure(_):
                self.showAlertWithTitle("Error", message: "Couldn't get the newspapers list. Go back and try again.")
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let newspaper = self.allNewspapers[indexPath.row]
        
        if self.newspaperSubscriptedIDs.contains(newspaper.id) {
            self.newspaperSubscriptedIDs = self.newspaperSubscriptedIDs.filter { $0 != newspaper.id }
        }else {
            self.newspaperSubscriptedIDs.append(newspaper.id)
        }
        
        UserNewspaperSession.saveNewspapersSubscription(self.newspaperSubscriptedIDs)
        
        self.dataSource = NewspaperSubscriptionDataSource(newspapers: self.allNewspapers, newspaperSubscribedIDs: self.newspaperSubscriptedIDs)
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }
}

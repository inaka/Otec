//
//  NewspaperNewsListViewController.swift
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
        NewsListener().listenToNewsWithEventSource(NewsListener().newsEventSource(), forNewspapersIDs: [self.newspaper.id]) { responseNew in
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

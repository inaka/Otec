//
//  NewsTableViewCell.swift
//  Otec
//
//  Created by El gera de la gente on 6/6/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsBodyLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newspaperNameLabel: UILabel!
    
    var news : News! {
        didSet {
            newspaperNameLabel.text = "by \(news.newspaper)"
            newsTitleLabel.text = news.title
            newsBodyLabel.text = news.body
        }
    }

}

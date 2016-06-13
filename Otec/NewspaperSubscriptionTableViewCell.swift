//
//  NewspaperSubscriptionTableViewCell.swift
//  Otec
//
//  Created by El gera de la gente on 6/13/16.
//  Copyright © 2016 Inaka. All rights reserved.
//

import UIKit

class NewspaperSubscriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var newspaperNameLabel: UILabel!
    @IBOutlet weak var newspaperDescriptionLabel: UILabel!

    var newspaper : Newspaper! {
        didSet {
            self.newspaperNameLabel.text = newspaper.id
            self.newspaperDescriptionLabel.text = newspaper.description
        }
    }
}

//
//  FilmCell.swift
//  swapi
//
//  Created by Benoit PASQUIER on 22/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

class FilmCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var film: Film? {
        didSet {
            titleLabel.text = film?.title
            
            if let opening = film?.openingCrawl {
                subtitleLabel.text = "Opening with \(opening.wordCount) words"
            } else {
                subtitleLabel.text = nil
            }
        }
    }
}

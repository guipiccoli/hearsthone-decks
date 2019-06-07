//
//  CardCollectionViewCell.swift
//  ios-HeartstoneAPI
//
//  Created by Guilherme Piccoli on 06/06/19.
//  Copyright © 2019 Guilherme Piccoli. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func prepareForReuse() {
        cardImageView.image = nil
    }
}

//
//  TidbitCollectionViewCell.swift
//  Edun_PhotoVault
//
//  Created by Jacob Shavel on 7/13/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import UIKit

class TidbitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tidbitText: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
        
    }

}

//
//  NumberCollectionViewCell.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/21.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    var isOpen : Bool = false
    
    @IBOutlet weak var numberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

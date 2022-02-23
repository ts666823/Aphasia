//
//  WordsChoiceCollectionViewCell.swift
//  Aphasia
//
//  Created by admin on 2021/11/13.
//

import UIKit

class WordsChoiceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/16
        label.layer.cornerRadius = self.frame.height/16
        super.awakeFromNib()
    }
}

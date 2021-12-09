//
//  WordCollectionViewCell.swift
//  Aphasia
//
//  Created by 唐烁 on 2021/8/30.
//

import UIKit

class WordCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.layer.cornerRadius = label.layer.frame.height/8
        label.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/16
        self.layer.masksToBounds = true
    }
}

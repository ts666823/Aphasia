//
//  SentenceCollectionViewCell.swift
//  Aphasia
//
//  Created by 唐烁 on 2022/1/26.
//

import UIKit

class SentenceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/8
    }
}

//
//  KeyWordsCollectionViewCell.swift
//  Aphasia
//
//  Created by admin on 2021/12/9.
//

import UIKit

class KeyWordsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var keywords: UILabel!
    @IBOutlet weak var content: UIImageView!
    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/8
        self.layer.borderColor = UIColor(red: 184/255, green: 182/255, blue: 237/255, alpha: 1).cgColor
        self.layer.borderWidth = 2
        super.awakeFromNib()
        
    }
}

//
//  PopOverCollectionViewCell.swift
//  Aphasia
//
//  Created by 唐烁 on 2021/11/13.
//

import UIKit

class PopOverCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageName:String!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.label.layer.cornerRadius = self.label.frame.height/8
        self.label.layer.masksToBounds = true
        self.layer.shadowColor = #colorLiteral(red: 0.431372549, green: 0.4156862745, blue: 0.8745098039, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = self.frame.height/16
        self.layer.masksToBounds = false
        
    }

}

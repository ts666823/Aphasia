//
//  CollectionViewCell.swift
//  Aphasia
//
//  Created by 唐烁 on 2021/8/29.
//

import UIKit

class ChooseCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                self.layer.masksToBounds = true
                self.layer.cornerRadius = 10
                self.layer.borderWidth = 2
                self.layer.borderColor = CGColor.init(red: 110/255, green: 106/255, blue: 223/255, alpha: 0.4)
                self.backgroundColor = UIColor.init(red: 110/255, green: 106/255, blue: 223/255, alpha: 0.1)
            }
            else{
                self.layer.borderWidth = 0
                self.backgroundColor = UIColor.init(red: 110/255, green: 106/255, blue: 223/255, alpha: 0)
            }
        }
    }
}

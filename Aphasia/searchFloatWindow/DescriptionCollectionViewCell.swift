//
//  DescriptionCollectionViewCell.swift
//  Aphasia
//
//  Created by admin on 2021/11/13.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate {

//    let vc = floatWindowViewController()
    func CGColorFromRGB(rgbValue: UInt) -> CGColor {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            ).cgColor
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/8
        super.awakeFromNib()
    }
    private var isSelect: Bool = false

    override var isSelected: Bool {
        set {
            self.isSelect = newValue
            if newValue {

                self.setSelectedStyle()
            } else {
                self.setDeSelectedStyle()
            }
        }
        get {
            return self.isSelect
        }
    }

    private func setSelectedStyle() {
//        self.backgroundColor = .purple
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor(hexString: "#F7F7FA").cgColor
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: "addLayerAnimationMargin")
        
        let animation2 = CABasicAnimation(keyPath: "borderWidth")
        animation2.toValue = 2
        animation2.duration = 1
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation2, forKey: "addLayerAnimationBorderWidth")
        self.layer.borderColor = CGColorFromRGB(rgbValue:0xC4C3F2)

    }

    private func setDeSelectedStyle() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor.white.cgColor
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: "addLayerAnimationMargin")
        
        let animation2 = CABasicAnimation(keyPath: "borderWidth")
        animation2.toValue = 2
        animation2.duration = 1
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation2, forKey: "addLayerAnimationBorderWidth")
        self.layer.borderColor = CGColorFromRGB(rgbValue: 0xFFFFFF)
    }
}

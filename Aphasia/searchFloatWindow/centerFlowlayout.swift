//
//  centerFlowlayout.swift
//  Aphasia
//
//  Created by admin on 2022/1/26.
//

import Foundation
import UIKit

class LastRowCenteredLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let originalAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        guard originalAttributes.isEmpty == false else { return originalAttributes }

        let finalAttributes = originalAttributes.map { $0.copy() as! UICollectionViewLayoutAttributes }

        // Find maxY among all element attributes, then all elements line up with that maxY. Those elements are the ones from the last row
        let maxY = finalAttributes.max { $0.frame.maxY < $1.frame.maxY }?.frame.maxY
        let lastRowAttrs = finalAttributes.filter { $0.frame.maxY == maxY }

        // If the elements in the last row don't sit flush against the right edge, then they need to be centered by shifting them a little to the right
        if lastRowAttrs.frame.maxX < insettedFrame.maxX {
            let shift = (insettedFrame.maxX - lastRowAttrs.frame.maxX) / 2.4
            
            for attrs in lastRowAttrs {
                attrs.frame = attrs.frame.offsetBy(dx: shift, dy: 0)
            }
        }
        
        return finalAttributes
    }
}


extension CGRect {
    func insettedBy(insets: UIEdgeInsets) -> CGRect {
        return self.inset(by: insets)
    }
}

extension Array where Element: UICollectionViewLayoutAttributes {
    var frame: CGRect {
        return map { $0.frame }.reduce(self[0].frame, { $0.union($1) })
    }
}

extension UICollectionViewFlowLayout {
    var insettedFrame: CGRect {
        guard let frame = collectionView?.frame else { return .zero }
        
        return frame.insettedBy(insets: sectionInset)
    }
}

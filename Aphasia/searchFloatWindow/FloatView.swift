//
//  FloatView.swift
//  Aphasia
//
//  Created by admin on 2022/1/27.
//

//
//  RedView.swift
//  Aphasia
//
//  Created by admin on 2021/11/14.
//

import UIKit

class FloatView: UIView {
    func superUIView(of: UIView) -> UIView? {
           for view in sequence(first: of.superview, next: { $0?.superview }) {
               if let cell = view {
                   return cell
               }
           }
           return nil
       }
    /*
        // Only override draw() if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        override func draw(_ rect: CGRect) {
            // Drawing code
        }
        */
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let viewFrame = self.frame.inset(by: UIEdgeInsets.init(top: 0, left: 0, bottom: 380, right: 0))
            if viewFrame.contains(point) {
                return self
            }
            return super.hitTest(point, with: event)
        }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取手指
        let touch = (touches as NSSet).anyObject() as! UITouch
        let nowLocation = touch.location(in: self)
        let preLocation = touch.previousLocation(in: self)

        //获取两个手指的偏移量
        let offsetX = nowLocation.x - preLocation.x
        let offsetY = nowLocation.y - preLocation.y
        let child = self
        let cell = superUIView(of: child)!
        var center = cell.center
        center.x += offsetX
        center.y += offsetY

        cell.center = center
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

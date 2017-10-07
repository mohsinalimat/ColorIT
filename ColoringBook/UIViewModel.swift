//
//  UIViewModel.swift
//  ColoringBook
//
//  Created by Admin on 2017-09-27.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import Foundation

extension UIView {
    
    /**
     Rotate a view by specified degrees
     
     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    
}

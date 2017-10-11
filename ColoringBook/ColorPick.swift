//
//  ColorPick.swift
//  ColoringBook
//
//  Created by MacBook Pro on 12/31/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

import UIKit

@IBDesignable class ColorPick: UIView {
    @IBInspectable var counterColor: UIColor = UIColor.red
    
    
    override func draw(_ rect: CGRect) {
        /*if palette==1{
         counterColor = UIColor.cyan
         }*/
        let startAngle: CGFloat = 1.375 * π
        //print(startAngle)
        let endAngle: CGFloat = 1.625 * π
        //print(endAngle)
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        // 1
        let radiusBorder: CGFloat = max(bounds.width, bounds.height)
        // 2
        let arcWidthBorder: CGFloat = 76//86
        
        
        //colorPickDownBorder----------------
        var path = UIBezierPath(rect: CGRect(x: center.x-43, y: 8.5, width: 86, height: 13.5))
        //path.lineWidth = 2.0
        
        counterColor.darker(by: 20)?.setFill()
        path.fill()
        //----------------------
        
        // 3
        path = UIBezierPath(arcCenter: center, radius: radiusBorder/2 - arcWidthBorder/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = arcWidthBorder
        counterColor.setStroke()
        path.stroke()
        
        let sAngle: CGFloat = π / 3
        let eAngle: CGFloat = (π / 3) - 0.00000000000001
        
        let arcBorder: CGFloat = 13
        
        let yPosition = bounds.height/2 - arcWidthBorder/2
        let centerMain = CGPoint(x: bounds.width/2, y: yPosition)
        
        let mainPath = UIBezierPath(arcCenter: centerMain, radius: 8, startAngle: sAngle, endAngle: eAngle, clockwise: true)
        
        mainPath.lineWidth = arcBorder
        counterColor.setStroke()
        mainPath.stroke()
        
        // 2
        let aBorder: CGFloat = 3
        // 3
        let dPath = UIBezierPath(arcCenter: centerMain, radius: 5, startAngle: sAngle, endAngle: eAngle, clockwise: true)
        
        dPath.lineWidth = aBorder
        UIColor.white.setStroke()
        dPath.stroke()
        
    }
}


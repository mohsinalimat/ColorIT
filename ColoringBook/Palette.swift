//
//  ColorView.swift
//  ColoringBook
//
//  Created by MacBook Pro on 12/28/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

import UIKit


@IBDesignable class Palette: UIView {
    
    @IBInspectable var counterColor: UIColor = UIColor.red
    var shadow: UIColor = UIColor.clear
    var colorArray = [UIColor]()
    var diffArray = [CGFloat]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, a: String, b:String, c:String, d:String, e:String, f:String, g:String, h:String){
        
        self.init(frame: frame)
        colorArray.removeAll()
        colorArray.append(UIColor.init(hexString: a)!)
        colorArray.append(UIColor.init(hexString: b)!)
        colorArray.append(UIColor.init(hexString: c)!)
        colorArray.append(UIColor.init(hexString: d)!)
        colorArray.append(UIColor.init(hexString: e)!)
        colorArray.append(UIColor.init(hexString: f)!)
        colorArray.append(UIColor.init(hexString: g)!)
        colorArray.append(UIColor.init(hexString: h)!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        
        
        // Add Color to the Array
        /*colorArray.append(UIColor.red)
         colorArray.append(UIColor.green)
         colorArray.append(UIColor.orange)
         colorArray.append(UIColor.yellow)
         colorArray.append(UIColor.blue)
         colorArray.append(UIColor.brown)
         colorArray.append(UIColor.magenta)
         colorArray.append(UIColor.purple)*/
        
        //counterColor = colorArray[0]
        // Draw Each angle to the View
        diffArray.append(1.375 * π)
        diffArray.append(1.625 * π)
        diffArray.append(1.875 * π)
        diffArray.append(0.125 * π)
        diffArray.append(0.375 * π)
        diffArray.append(0.625 * π)
        diffArray.append(0.875 * π)
        diffArray.append(1.125 * π)
        diffArray.append(1.375 * π)
        
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        print(center)
        
        // 2
        let radius: CGFloat = max(bounds.width-25, bounds.height-25)
        print(radius)
        
        // 3
        let arcWidth: CGFloat = 60//76
        
        // 4
        //let startAngle: CGFloat = π / 3
        //print(startAngle)
        //let endAngle: CGFloat = (π / 3) - 0.00000000000001
        //print(endAngle)
        
        //        // 5
        //        let path = UIBezierPath(arcCenter: center,
        //                                radius: radius/2 - arcWidth/2,
        //                                startAngle: startAngle,
        //                                endAngle: endAngle,
        //                                clockwise: true)
        //
        //        print(path)
        //
        //        // 6
        //        path.lineWidth = arcWidth
        //        counterColor.setStroke()
        //        path.stroke()
        
        
        print("asdf \(radius/2 - arcWidth/2)")
        /*let path = UIBezierPath(arcCenter: center, radius: bounds.width/2, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi*2), clockwise: true)
         //let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 50)
         path.lineWidth = arcWidth
         //shadow = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
         shadow.setFill()
         path.fill()*/
        
        
        for index in 0..<colorArray.count {
            
            let path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: diffArray[index], endAngle: diffArray[index + 1], clockwise: true)
            
            path.lineWidth = arcWidth
            colorArray[index].setStroke()
            path.stroke()
        }
        /*print("asdf \(radius/2 - arcWidth/2)")
         let path = UIBezierPath(arcCenter: center, radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi*2), clockwise: true)
         //let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 50)
         path.lineWidth = arcWidth
         UIColor.red.setFill()
         path.fill()*/
        //UIColor.red.setStroke()
        //path.stroke()
        
        //        let startAngle: CGFloat = π / 3
        //        //print(startAngle)
        //        let endAngle: CGFloat = (π / 3) - 0.00000000000001
        //        //print(endAngle)
        //
        //
        //        // 1
        //        let radiusBorder: CGFloat = max(bounds.width, bounds.height)
        //        print(radius)
        //
        //        // 2
        //        let arcWidthBorder: CGFloat = 3
        //
        //        // 3
        //        let path = UIBezierPath(arcCenter: center, radius: radiusBorder/2 - arcWidthBorder/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        //
        //        path.lineWidth = arcWidthBorder
        //        colorArray[0].setStroke()
        //        path.stroke()
        
    }
}

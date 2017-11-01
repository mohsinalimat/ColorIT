//
//  CustomWhellViewController.swift
//  ColoringBook
//
//  Created by Odyssey Apps on 9/20/17.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import UIKit

class CustomWhellViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var labelPalNum: UILabel!
    @IBOutlet weak var labelPalName: UILabel!
    @IBOutlet weak var saturatinolbl: UILabel!
    @IBOutlet weak var brightnesslbl: UILabel!
    @IBOutlet weak var colorlbl: UILabel!
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var customMiddleView: UIView!
    @IBOutlet weak var textFieldPal: UITextField!
    @IBOutlet weak var customColorView: customWhellView!
    @IBOutlet weak var brightSlider: UISlider!
    @IBOutlet weak var SaturatSlider: UISlider!
    @IBOutlet weak var colorSlider: UISlider!
    @IBOutlet weak var customColorPick: ColorPick!
    var customColorArray = [UIColor]()
    var ButtonTappedInRect = false
    var angle: CGFloat = 0.0
    var selectedColor: UIColor = UIColor.red
    var animAngle:CGFloat = -0.01
    var tapped:Bool = false
    var previousPos:CGPoint = CGPoint(x: 0, y: 0)
    var colorValue : CGFloat = 0.3
    var saturatValue : CGFloat = 0.5
    var brightValue : CGFloat = 0.5
    var activePalette = Int()
    enum mode {
        case newMode
        case editMode
    }
    var Palettemode = mode.newMode
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if !HelperMethods.isIphone(){
            
            customColorView.frame = CGRect(x: self.view.center.x-500/2, y: 100, width: 500, height: 500)
            customColorPick.frame = CGRect(x: self.view.center.x-500/2, y: 100, width: 500, height: 500)
            customMiddleView.frame = CGRect(x: 0, y: 0, width: 170, height: 170)
            labelPalNum.frame = CGRect(x: 0, y: 0, width: 170, height: 170)
            labelPalName.frame = CGRect(x: 0, y: 0, width: 170, height: 170)
            textFieldPal.frame = CGRect(x: 0, y: 170/2-60/2, width: 170, height: 60)
            customMiddleView.layer.cornerRadius = 85.0
            labelPalName.layer.cornerRadius = 85.0
            labelPalNum.layer.cornerRadius = 85.0
            labelPalNum.font = UIFont(name: "Baskerville-Bold", size: 130)
            labelPalName.font = UIFont(name: "Baskerville-Bold", size: 24)
            textFieldPal.font = UIFont(name: "Baskerville-Bold", size: 24)
            colorSlider.frame = CGRect(x: 50, y: 650, width: self.view.frame.width-100, height: 60)
            SaturatSlider.frame = CGRect(x: 50, y: 700, width: self.view.frame.width-100, height: 60)
            brightSlider.frame = CGRect(x: 50, y: 750, width: self.view.frame.width-100, height: 60)
            colorlbl.frame = CGRect(x: self.view.frame.width - 170, y: 640, width: 120, height: 30)
            saturatinolbl.frame = CGRect(x: self.view.frame.width - 170, y: 690, width: 120, height: 30)
            brightnesslbl.frame = CGRect(x: self.view.frame.width - 170, y: 740, width: 120, height: 30)
            colorlbl.font = UIFont(name: "Baskerville", size: 24)
            saturatinolbl.font = UIFont(name: "Baskerville", size: 24)
            brightnesslbl.font = UIFont(name: "Baskerville", size: 24)
            savebtn.frame = CGRect(x: self.view.frame.width/2 - 250, y: self.view.frame.height - 95, width: 500, height: 65)
        }
        else{
            customColorView.frame = CGRect(x: self.view.center.x-225/2, y: 80, width: 225, height: 225)
            customColorPick.frame = CGRect(x: self.view.center.x-225/2, y: 80, width: 225, height: 225)
            customMiddleView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            labelPalNum.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            labelPalName.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            textFieldPal.frame = CGRect(x: 0, y: 80/2-30/2, width: 80, height: 30)
            customMiddleView.layer.cornerRadius = 40.0
            labelPalName.layer.cornerRadius = 40.0
            labelPalNum.layer.cornerRadius = 40.0
        
            colorSlider.frame = CGRect(x: 25, y: 340, width: self.view.frame.width-50, height: 30)
            SaturatSlider.frame = CGRect(x: 25, y: 380, width: self.view.frame.width-50, height: 30)
            brightSlider.frame = CGRect(x: 25, y: 420, width: self.view.frame.width-50, height: 30)
            colorlbl.frame = CGRect(x: self.view.frame.width - 135, y: 330, width: 85, height: 30)
            saturatinolbl.frame = CGRect(x: self.view.frame.width - 135, y: 370, width: 85, height: 30)
            brightnesslbl.frame = CGRect(x: self.view.frame.width - 135, y: 410, width: 85, height: 30)
            savebtn.frame = CGRect(x: self.view.frame.width/2 - 112.5, y: self.view.frame.height - 75, width: 225, height: 55)
        }
        colorlbl.text = "Color".localize()
        saturatinolbl.text = "Saturation".localize()
        brightnesslbl.text = "Brightness".localize()
        savebtn.setTitle("Save Palette".localize(), for: .normal)
        customMiddleView.center = customColorView.center
        createView()
        //print(generatedWheels[0].number)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.customVC = self
        if Palettemode == .newMode{
            rewardedAdd()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    func unityRewardAd(){
        UnityAds.show(self, placementId: "rewardedVideo")
    }
    func rewardedAdd(){
        /*if Chartboost.hasRewardedVideo(CBLocationHomeScreen) == true{
         Chartboost.showRewardedVideo(CBLocationHomeScreen)
         }
         else{
         Chartboost.cacheRewardedVideo(CBLocationHomeScreen)
         }*/
        Chartboost.showRewardedVideo(CBLocationHomeScreen)
        
    }
    func createView(){
        //customColorView.colorArray.removeAll()
        if Palettemode == .newMode{
            
            customColorView.colorArray.append(UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0))
            customColorView.colorArray.append(UIColor.white)
            customColorView.colorArray.append(UIColor.white)
            customColorView.colorArray.append(UIColor.white)
            customColorView.colorArray.append(UIColor.white)
            customColorView.colorArray.append(UIColor.white)
            customColorView.colorArray.append(UIColor.white)
            customColorView.colorArray.append(UIColor.white)
            
            labelPalNum.text = "\(numberOfWheels+generatedWheels.count)"
        }
        else{
            customColorView.colorArray = customColorArray
            if activePalette<=79{
                labelPalNum.text = "\(activePalette+1)"
            }
            else{
                labelPalNum.text = "\(activePalette)"
            }
            
            labelPalName.text = "\(generatedWheels[activePalette-numberOfWheels].name)"
        }
        textFieldPal.isHidden=true
        
        customColorPick.counterColor = customColorView.colorArray[0]
        selectedColor = customColorView.colorArray[0]
        var a = CGFloat()
        selectedColor.getHue(&colorValue, saturation: &saturatValue, brightness: &brightValue, alpha: &a)
        
        SaturatSlider.value = Float(saturatValue)
        colorSlider.value = Float(colorValue)
        brightSlider.value = Float(brightValue)
    }
    func lblTapped(){
        labelPalName.isHidden=true
        textFieldPal.isHidden=false
        textFieldPal.becomeFirstResponder()
        textFieldPal.text=labelPalName.text
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldPal.isHidden=true
        labelPalName.isHidden=false
        labelPalName.text=textFieldPal.text
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! + string)
        if str.characters.count>8{
            textField.font=UIFont(name: "HelveticaNeue-Bold", size: 12)
            labelPalName.font=UIFont(name: "HelveticaNeue-Bold", size: 12)
        }
        else{
            textField.font=UIFont(name: "HelveticaNeue-Bold", size: 14)
            labelPalName.font=UIFont(name: "HelveticaNeue-Bold", size: 14)
        }
        if str.characters.count <= 10 {
            return true
        }
        textField.text = str.substring(to: str.index(str.startIndex, offsetBy: 10))
        return false
    }
    
    @IBAction func brightSliderValueDidChange (_ sender: UISlider) {
        print(sender.value)
        brightValue = CGFloat(sender.value)
        randomColorPicker(setValue: true)
        customColorPick.counterColor = selectedColor
        customColorPick.setNeedsDisplay()
        customColorView.setNeedsDisplay()
        
    }
    @IBAction func saturateSliderValueDidChange (_ sender: UISlider) {
        print(sender.value)
        saturatValue = CGFloat(sender.value)
        randomColorPicker(setValue: true)
        customColorPick.counterColor = selectedColor
        customColorPick.setNeedsDisplay()
        customColorView.setNeedsDisplay()
    }
    @IBAction func colorSliderValueDidChange (_ sender: UISlider) {
        print(sender.value)
        colorValue = CGFloat(sender.value)
        randomColorPicker(setValue: true)
        customColorPick.counterColor = selectedColor
        customColorPick.setNeedsDisplay()
        customColorView.setNeedsDisplay()
    }
    @IBAction func savePalette(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        for index in 0..<8
        {
            var h = CGFloat()
            var s = CGFloat()
            var b = CGFloat()
            var a = CGFloat()
            customColorView.colorArray[index].getHue(&h, saturation: &s, brightness: &b, alpha: &a)
            if s >= 0.9{
                customColorView.colorArray[index] = UIColor(hue: h, saturation: s-(CGFloat(index)*CGFloat(0.005)), brightness: b, alpha: a)
            }
            else{
                customColorView.colorArray[index] = UIColor(hue: h, saturation: s+(CGFloat(index)*CGFloat(0.005)), brightness: b, alpha: a)
            }
        }
        if Palettemode == .newMode{
            DatabaseController.setValueToDataBase(no: Int64(numberOfWheels+generatedWheels.count), name: labelPalName.text!, col1: customColorView.colorArray[0].toHexString(), col2: customColorView.colorArray[1].toHexString(), col3: customColorView.colorArray[2].toHexString(), col4: customColorView.colorArray[3].toHexString(), col5: customColorView.colorArray[4].toHexString(), col6: customColorView.colorArray[5].toHexString(), col7: customColorView.colorArray[6].toHexString(), col8: customColorView.colorArray[7].toHexString())
        }
        else{
            //Edit color Palette ; Update Database
            print(activePalette)
            DatabaseController.editDataFromDatabase(number: Int64(activePalette), name: labelPalName.text!, col1: customColorView.colorArray[0].toHexString(), col2: customColorView.colorArray[1].toHexString(), col3: customColorView.colorArray[2].toHexString(), col4: customColorView.colorArray[3].toHexString(), col5: customColorView.colorArray[4].toHexString(), col6: customColorView.colorArray[5].toHexString(), col7: customColorView.colorArray[6].toHexString(), col8: customColorView.colorArray[7].toHexString())
        }
        
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem){
        HelperMethods.Alerts(VC: self, header: "", message: "Are you sure you want to discard changes?", btn1Name: "OK", btn2Name: "Cancel") {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func DeleteButton(_ sender: UIBarButtonItem){
        
        if Palettemode == .editMode{
            //Delete color Palette ; Update Database
            print(activePalette)
            DatabaseController.deleteDataFromDatabase(number: generatedWheels[activePalette-numberOfWheels].number, arrayIndx: Int64(activePalette))
        }
        HelperMethods.Alerts(VC: self, header: "", message: "Are you sure you want to delete the palette?", btn1Name: "OK", btn2Name: "Cancel") {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func plusMinusOverload (first: CGPoint, second: CGPoint, option: Int64) -> CGPoint {
        if option==0{
            return CGPoint(x: first.x - second.x,y: first.y - second.y)
        }
        else{
            return CGPoint(x: first.x + second.x,y: first.y + second.y)
        }
        
    }
    func incDecOverload (first: CGPoint, second: CGPoint, option: Int64) -> Bool {
        if option==0{
            if first.x>second.x && first.y>second.y{
                return true
            }
            return false
        }
        else{
            if second.x>first.x && second.y>first.y{
                return true
            }
            return false
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tapped=true
        if let touch = touches.first {
            let position = touch.location(in: self.view)
            if incDecOverload(first: plusMinusOverload(first: customColorView.center, second: CGPoint(x: customColorView.frame.size.width/2,y: customColorView.frame.size.width/2), option: 0),second: position,option: 1) && incDecOverload(first: plusMinusOverload(first: customColorView.center, second: CGPoint(x: customColorView.frame.size.width/2,y: customColorView.frame.size.width/2), option: 1),second: position,option: 0){
                
                print("POSITION: \(position)")
                let target = customColorView.center
                print("TARGET: \(target)")
                angle = atan2(target.y - position.y, target.x - position.x)
                print("ANGLE: \(angle)")
                
                ButtonTappedInRect=true
            }
            else{
                ButtonTappedInRect=false
            }
            
        }
        print("ANGLE: \(angle)")
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        tapped=false
        let touch: UITouch = touches.first!
        
        
        if ButtonTappedInRect{
            
            var currentTouch = touch.location(in: self.view)
            var previousTouch = touch.previousLocation(in: self.view)
            
            currentTouch.x = currentTouch.x - customColorView.center.x
            currentTouch.y = customColorView.center.y - currentTouch.y
            
            previousTouch.x = previousTouch.x - customColorView.center.x
            previousTouch.y = customColorView.center.y - previousTouch.y
            
            let angleDifference = atan2(previousTouch.y, previousTouch.x) - atan2(currentTouch.y, currentTouch.x)
            
            
            angle = atan2(self.view.transform.a, self.view.transform.b) + atan2(self.customColorView.transform.a, self.customColorView.transform.b);
            //print("angle: \(angle)")
            
            
            UIView.animate(withDuration: 0.05, animations: { () -> Void in
                self.customColorView.transform = self.customColorView.transform.rotated(by: angleDifference)
            })
        }
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        //let fraction = angle.remainder(dividingBy: 0.7854)
        //print(" Fraction: \(fraction)")
        
        if tapped == true
        {
            //let touch: UITouch = touches.first!
            
            if let touch = touches.first {
                let position = touch.location(in: self.view)
                let distance = (pow(customColorView.center.x - position.x,2) + pow(customColorView.center.y - position.y,2))
                if distance < pow(customMiddleView.frame.size.width/2,2){
                    
                    lblTapped()
                    
                }
                else{
                    
                }
            }
        }
        else{
            
            colorSelectionWithMotion()
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.customColorView.transform = CGAffineTransform(rotationAngle: CGFloat(self.animAngle))
            //self.customColorView.transform = self.customColorView.transform.rotated(by: self.angle)
        })
        
        
        //customColorView.colorArray.removeAll()
        //customColorView.colorArray[0] = uico
        //        customColorView.colorArray.append(UIColor.green)
        //        customColorView.colorArray.append(UIColor.red)
        //        customColorView.colorArray.append(UIColor.green)
        //        customColorView.colorArray.append(UIColor.red)
        //        customColorView.colorArray.append(UIColor.green)
        //        customColorView.colorArray.append(UIColor.red)
        //        customColorView.colorArray.append(UIColor.green)
        randomColorPicker(setValue: false)
        customColorPick.counterColor = selectedColor
        customColorPick.setNeedsDisplay()
        customColorView.setNeedsDisplay()
        
        var a = CGFloat()
        selectedColor.getHue(&colorValue, saturation: &saturatValue, brightness: &brightValue, alpha: &a)
        
        SaturatSlider.value = Float(saturatValue)
        colorSlider.value = Float(colorValue)
        brightSlider.value = Float(brightValue)
    }
    func randomColorPicker(setValue: Bool){
        if animAngle == -0.01{
            if customColorView.colorArray[0] != UIColor.white{
                if setValue==true
                {
                    customColorView.colorArray[0] = UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0)
                }
                
            }
            else{
                customColorView.colorArray[0] = UIColor(hue: CGFloat(0.2), saturation: CGFloat(0.4), brightness: CGFloat(0.4), alpha: 1.0)
            }
            selectedColor = customColorView.colorArray[0]
            
            //selectedColor = UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0)
            
        }
        else if animAngle == -0.78{
            if customColorView.colorArray[1] != UIColor.white{
                if setValue==true{
                    customColorView.colorArray[1] = UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0)
                }
            }
            else{
                customColorView.colorArray[1] = UIColor(hue: CGFloat(0.4), saturation: CGFloat(0.3), brightness: CGFloat(0.6), alpha: 1.0)
            }
            selectedColor = customColorView.colorArray[1]
        }
        else if animAngle == -1.58{
            if customColorView.colorArray[2] != UIColor.white{
                if setValue==true{
                    customColorView.colorArray[2] = UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0)
                }
            }
            else{
                customColorView.colorArray[2] = UIColor(hue: CGFloat(0.4), saturation: CGFloat(0.1), brightness: CGFloat(0.8), alpha: 1.0)
            }
            selectedColor = customColorView.colorArray[2]
        }
        else if animAngle == -2.35{
            if customColorView.colorArray[3] != UIColor.white{
                if setValue==true{
                    customColorView.colorArray[3] = UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0)
                }
            }
            else{
                customColorView.colorArray[3] = UIColor(hue: CGFloat(1.0), saturation: CGFloat(0.2), brightness: CGFloat(0.7), alpha: 1.0)
            }
            selectedColor = customColorView.colorArray[3]
        }
        else if animAngle == 3.14{
            if customColorView.colorArray[4] != UIColor.white{
                if setValue==true{
                    customColorView.colorArray[4] = UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0)
                }
            }
            else{
                customColorView.colorArray[4] = UIColor(hue: CGFloat(0.4), saturation: CGFloat(0.2), brightness: CGFloat(0.7), alpha: 1.0)
            }
            selectedColor = customColorView.colorArray[4]
        }
        else if animAngle == 2.34{
            if customColorView.colorArray[5] != UIColor.white{
                if setValue==true{
                    customColorView.colorArray[5] = UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0)
                }
            }
            else{
                customColorView.colorArray[5] = UIColor(hue: CGFloat(0.5), saturation: CGFloat(1.0), brightness: CGFloat(0.7), alpha: 1.0)
            }
            selectedColor = customColorView.colorArray[5]
        }
        else if animAngle == 1.57{
            if customColorView.colorArray[6] != UIColor.white{
                if setValue==true{
                    customColorView.colorArray[6] = UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0)
                }
            }
            else{
                customColorView.colorArray[6] = UIColor(hue: CGFloat(0.7), saturation: CGFloat(0.6), brightness: CGFloat(1.0), alpha: 1.0)
            }
            selectedColor = customColorView.colorArray[6]
        }
        else if animAngle == 0.78{
            if customColorView.colorArray[7] != UIColor.white{
                if setValue==true{
                    customColorView.colorArray[7] = UIColor(hue: CGFloat(colorValue), saturation: CGFloat(saturatValue), brightness: CGFloat(brightValue), alpha: 1.0)
                }
            }
            else{
                customColorView.colorArray[7] = UIColor(hue: CGFloat(0.5), saturation: CGFloat(0.2), brightness: CGFloat(0.7), alpha: 1.0)
            }
            selectedColor = customColorView.colorArray[7]
        }
    }
    func colorSelectionWithMotion(){
        if (0 < angle && angle < 0.78)  {
            
            let newAngle = 0 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 0.78 {
                animAngle=2.34
                print("asdf")
                
            } else {
                
                animAngle=3.14
            }
            
        }
        else if (0.78 < angle && angle < 1.57)  {
            let newAngle = 0.78 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 1.57 {
                
                animAngle=1.57
                print("asdf")
            } else {
                
                animAngle=2.34
            }
        }
        else if (1.57 < angle && angle < 2.34)  {
            let newAngle = 1.57 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 2.34 {
                
                animAngle=0.78
                print("asdf")
            } else {
                
                animAngle=1.57
            }
        }
        else if (2.34 < angle && angle < 3.14)  {
            let newAngle = 2.34 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 3.14 {
                
                animAngle = -0.01
                print("asdf")
            } else {
                
                animAngle=0.78
            }
        }
        else if (3.14 < angle && angle < 3.92)  {
            let newAngle = 3.14 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 3.92 {
                
                animAngle = -0.78
                print("asdf")
            } else {
                
                animAngle = -0.01
            }
        }
        else if (3.92 < angle && angle < 4.70)  {
            let newAngle = 3.92 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 4.70 {
                
                animAngle = -1.58
                print("asdf")
            } else {
                
                animAngle = -0.78
            }
        }
        else if (-1.58 < angle && angle < -0.78)  {
            let newAngle = -1.58 + 0.4
            
            if CGFloat(newAngle) < angle && angle < -0.78 {
                
                animAngle = -2.35
                print("asdf")
            } else {
                
                animAngle = -1.58
            }
        }
        else if (-0.78 < angle && angle < 0)  {
            let newAngle = -0.78 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 0 {
                
                animAngle = 3.14
                print("asdf")
            } else {
                
                animAngle = -2.35
            }
        }
        
    }
    func getPixelColorAtPoint(point:CGPoint) -> UIColor {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        customColorView.layer.render(in: context!)
        let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0, green: CGFloat(pixel[1])/255.0, blue: CGFloat(pixel[2])/255.0, alpha: CGFloat(pixel[3])/255.0)
        
        pixel.deallocate(capacity: 4)
        return color
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  HelperMethods.swift
//  ColoringBook
//
//  Created by Odyssey Apps on 10/8/17.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import Foundation
class HelperMethods{
    
    
    static func customFilters(image: UIImage, pureImage: UIImage, contourName: SharingViewController.contourList, textureName: SharingViewController.textureList, size: CGSize, sliderValue: CGFloat) -> UIImage{
        //Textures
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if textureName == .knit{
            #imageLiteral(resourceName: "knitted").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .leath{
             #imageLiteral(resourceName: "leather").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .stonwall{
            #imageLiteral(resourceName: "Stone-Wall").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .wallred2{
            #imageLiteral(resourceName: "wall-red-brick-2").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .wallred{
            #imageLiteral(resourceName: "wall-red-brick").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .wallwhit{
            #imageLiteral(resourceName: "wall-white").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .wall{
            #imageLiteral(resourceName: "wall").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .wood1{
            #imageLiteral(resourceName: "wood-1").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .wood{
            #imageLiteral(resourceName: "wood").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .none{
           
        }
        
        //Contours
        if contourName == .black{
            
            contourFilter(image: pureImage).draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .screen, alpha: 1.0)
        }
        else if contourName == .white{
            
            contourFilter(image: pureImage).draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .plusLighter, alpha: 1.0)
        }
        else{
            
        }
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return processVintageImage(newImage, vintageSliderValue: sliderValue)
        
    }
    static func contourFilter(image: UIImage)->UIImage {
        var filter = CIFilter(name: "CIColorInvert")
        let beginImage = CIImage(image: image)
        filter?.setValue(beginImage, forKey: kCIInputImageKey)
        let inverseImage = filter?.outputImage
        //let inverseImage = UIImage(ciImage: (filter?.outputImage!)!)
        
        //let entryImage: UIImage? = image
        //let context = CIContext(options: nil)
        //let image = CIImage(cgImage: (entryImage?.cgImage)!)
        filter = CIFilter(name: "CIMaskToAlpha")
        //filter?.setDefaults()
        filter?.setValue(inverseImage, forKey: kCIInputImageKey)
        //    CIImage *result = [filter valueForKey:kCIOutputImageKey];
        let result: CIImage? = filter?.outputImage
        let newImage = UIImage(ciImage: result!)
        //let cgImage = context.createCGImage(result!, from: (result?.extent)!)
        //let newImage = UIImage(cgImage: cgImage!, scale: (entryImage?.scale)!, orientation: .up)
        //super.setImage(newImage as? CIImage ?? CIImage())
        return newImage
    }
    
    static func processVintageImage(_ image: UIImage, vintageSliderValue: CGFloat) -> UIImage {
        
        guard let inputImage = CIImage(image: image) else { return image }
        
        guard /*let photoFilter = CIFilter(name: "CIPhotoEffectInstant",
             withInputParameters: ["inputImage" : inputImage]),
             let photoOutput = photoFilter.outputImage,
             let sepiaFilter = CIFilter(name: "CISepiaTone",
             withInputParameters: ["inputImage": photoOutput]),
             let sepiaFilterOutput = sepiaFilter.outputImage,*/
            let vignetteFilter = CIFilter(name: "CIVignette",
                                          withInputParameters: ["inputImage": inputImage, "inputRadius" : vintageSliderValue*2, "inputIntensity" : vintageSliderValue*2]),
            let vignetteFilterOutput = vignetteFilter.outputImage else { return image }
        
        let context = CIContext(options: nil)
        
        let cgImage = context.createCGImage(vignetteFilterOutput, from: inputImage.extent)
        
        return UIImage(cgImage: cgImage!)
    }
    static func isIphone()->Bool{
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            print("iPhone")
            return true
        }
        return false
    }
    static func Alerts(VC: UIViewController, header: String, message: String, btn1Name: String, btn2Name: String, handlerBtn1: @escaping (()->Void)){
    
        let alert = UIAlertController(title: NSLocalizedString(header, comment: "title"), message: NSLocalizedString(message, comment: "message"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString(btn1Name, comment: "title"), style: .default, handler: {(action:UIAlertAction) in
            
            handlerBtn1()
            
        }))
        
        alert.addAction( UIAlertAction(title: NSLocalizedString(btn2Name, comment: "title"), style: .cancel,handler: {(action:UIAlertAction) in
            
            
            
        }))
        VC.present(alert, animated: true, completion: nil)

    }
}


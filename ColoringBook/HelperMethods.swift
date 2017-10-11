//
//  HelperMethods.swift
//  ColoringBook
//
//  Created by Odyssey Apps on 10/8/17.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import Foundation
class HelperMethods{
    
    
    static func customFilters(image: UIImage, contourName: SharingViewController.contourList, textureName: SharingViewController.textureList, size: CGSize, sliderValue: CGFloat) -> UIImage{
    
        //Textures
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if textureName == .bricks{
            #imageLiteral(resourceName: "wall").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .paper{
             #imageLiteral(resourceName: "paper").draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .multiply, alpha: 1.0)
        }
        else if textureName == .none{
           
        }
        
        //Contours
        if contourName == .black{
            
            contourFilter(image: #imageLiteral(resourceName: "Birds1.png")).draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .screen, alpha: 1.0)
        }
        else if contourName == .white{
            
            contourFilter(image: #imageLiteral(resourceName: "Birds1.png")).draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .plusLighter, alpha: 1.0)
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
    
}

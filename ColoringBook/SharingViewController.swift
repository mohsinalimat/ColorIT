//
//  SharingViewController.swift
//  ColoringBook
//
//  Created by Odyssey Apps on 9/28/17.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import UIKit
import Foundation
import FacebookShare
import FBSDKMessengerShareKit

class SharingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var buttonHeight:CGFloat = 60.0
    var textureButtonHeight:CGFloat = 80.0
    var vintageSliderValue:CGFloat = 0.0
    let buttonDistance = {(view:CGFloat,numberOfBtn:CGFloat,btnSize:CGFloat)->CGFloat in
        return (view-(numberOfBtn*btnSize))/(numberOfBtn+1.0)
    }
    /*var buttonDistace:CGFloat {
     return (self.view.frame.size.width-(4*buttonHeight))/(4.0+1.0)
     }*/
    let blendEffects:[CGBlendMode] = [.normal, .multiply, .screen, .overlay, .darken, .lighten, .colorDodge, .colorBurn, .softLight, .hardLight, .difference, .exclusion, .hue, .saturation, .color, .luminosity, .clear, .copy, .sourceIn, .sourceOut, .sourceAtop, .destinationOver, .destinationIn, .destinationOut, .destinationAtop, .xor, .plusDarker, .plusLighter]
    enum contourList {
        case black
        case white
        case none
    }
    enum textureList{
        case none
        case knit
        case leath
        case stonwall
        case wallred2
        case wallred
        case wallwhit
        case wall
        case wood1
        case wood
    }
    var contoureName = contourList.none
    var textureName = textureList.none
    var coloredImage = UIImage()
    var coloredImageNew = UIImage()
    var coloredImageView = UIImageView()
    var containerView = UIView()
    var textureView = UIView()
    var contourView = UIView()
    var vignetteView = UIView()
    var bottomCollectionView: UICollectionView!
    enum textures {
        case vignette
        case contour
        case texture
    }
    var textureMode = textures.contour
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !HelperMethods.isIphone(){
            buttonHeight = 80.0
        }
        textureButtonHeight = self.view.frame.height/6.0
        
        
        createView()
        // Do any additional setup after loading the view.
    }
    
    func createView(){
        
        coloredImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        coloredImageView.image = coloredImage
        coloredImageView.center = self.view.center
        self.view.addSubview(coloredImageView)
        containerView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height/2 - buttonHeight/2.0))
        containerView.backgroundColor=UIColor.white
        self.view.addSubview(containerView)
        // sharing Buttons
        let shareButton1 = UIButton(frame: CGRect(x: buttonDistance(self.view.frame.size.width,4.0,buttonHeight), y: -20, width: buttonHeight, height: buttonHeight))
        shareButton1.backgroundColor=UIColor.clear
        shareButton1.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        shareButton1.addTarget(self, action: #selector(uploadToFB), for: .touchUpInside)
        containerView.addSubview(shareButton1)
        let shareButton2 = UIButton(frame: CGRect(x: 2*buttonDistance(self.view.frame.size.width,4.0,buttonHeight)+buttonHeight, y: -20, width: buttonHeight, height: buttonHeight))
        shareButton2.backgroundColor=UIColor.clear
        shareButton2.setImage(#imageLiteral(resourceName: "linkedin"), for: .normal)
        shareButton2.addTarget(self, action: #selector(uploadToMessenger), for: .touchUpInside)
        containerView.addSubview(shareButton2)
        let shareButton3 = UIButton(frame: CGRect(x: 3*buttonDistance(self.view.frame.size.width,4.0,buttonHeight)+2*buttonHeight, y: -20, width: buttonHeight, height: buttonHeight))
        shareButton3.backgroundColor=UIColor.clear
        shareButton3.setImage(#imageLiteral(resourceName: "instagram"), for: .normal)
        shareButton3.addTarget(self, action: #selector(uploadToInstagram), for: .touchUpInside)
        containerView.addSubview(shareButton3)
        let shareButton4 = UIButton(frame: CGRect(x: 4*buttonDistance(self.view.frame.size.width,4.0,buttonHeight)+3*buttonHeight, y: -20, width: buttonHeight, height: buttonHeight))
        shareButton4.backgroundColor=UIColor.clear
        shareButton4.setImage(#imageLiteral(resourceName: "twitter"), for: .normal)
        shareButton4.addTarget(self, action: #selector(airdrop), for: .touchUpInside)
        containerView.addSubview(shareButton4)
        
        let items = ["Texture".localize(), "Contour".localize(), "Vignette".localize()]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        
        // Set up Frame and SegmentedControl
        let frame = containerView.frame
        if HelperMethods.isIphone(){
            customSC.frame = CGRect(x: 0, y: 90, width: frame.width, height: 40)
        }
        else{
            customSC.frame = CGRect(x: 0, y: 120, width: frame.width, height: 60)
        }
        
        
        // Style the Segmented Control
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        customSC.tintColor = UIColor.white
        customSC.layer.borderWidth=2.0
        customSC.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        //customSC.layer.borderColor=UIColor.black as! CGColor
        let font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        
        customSC.setTitleTextAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.black], for: UIControlState.selected)
        
        //default title text color
        customSC.setTitleTextAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.darkGray], for: UIControlState.normal)
        
        // Add target action method
        customSC.addTarget(self, action: #selector(changeContainerView(sender:)), for: .valueChanged)
        
        // Add this custom Segmented Control to our view
        self.containerView.addSubview(customSC)
        createTextureCollectionView()
        
        
    }
    
    func changeContainerView(sender: UISegmentedControl) {
        //println("Change color handler is called.")
        print("Changing Color to ")
        switch sender.selectedSegmentIndex {
        case 0:
            //self.view.backgroundColor = UIColor.green
            createTextureCollectionView()
        //print("Green")
        case 1:
            //self.view.backgroundColor = UIColor.blue
            createContourView()
        //print("Blue")
        default:
            //self.view.backgroundColor = UIColor.purple
            createVignetteView()
            //print("Purple")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.7, animations: {
            self.coloredImageView.transform = self.coloredImageView.transform.scaledBy(x: 0.7, y: 0.7)
            self.coloredImageView.transform = self.coloredImageView.transform.translatedBy(x: 0, y: -self.view.frame.size.height/4)
            self.containerView.transform = self.containerView.transform.translatedBy(x: 0, y: -self.view.frame.size.height/2+self.buttonHeight/2.0)
        }, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.7, animations: {
            self.coloredImageView.transform = self.coloredImageView.transform.scaledBy(x: 1.0/0.7, y: 1.0/0.7)
            self.coloredImageView.transform = self.coloredImageView.transform.translatedBy(x: 0, y: self.view.frame.size.height/6)
            self.containerView.transform = self.containerView.transform.translatedBy(x: 0, y: self.view.frame.size.height/2-self.buttonHeight/2.0)
        }, completion:{(finished: Bool) in
            
            self.dismiss(animated: false, completion: nil)
        })
        
    }
    @IBAction func bookmarksButton(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.7, animations: {
            self.coloredImageView.transform = self.coloredImageView.transform.scaledBy(x: 1.0/0.7, y: 1.0/0.7)
            self.coloredImageView.transform = self.coloredImageView.transform.translatedBy(x: 0, y: self.view.frame.size.height/6)
            self.containerView.transform = self.containerView.transform.translatedBy(x: 0, y: self.view.frame.size.height/2-self.buttonHeight/2.0)
        }, completion:{(finished: Bool) in
            //perform segue to root view
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
            self.present(secondViewController, animated: false, completion: nil)
            //self.dismiss(animated: false, completion: nil)
        })
    }
    func createTextureCollectionView(){
        if textureMode == .contour{
            contourView.removeFromSuperview()
        }
        else if textureMode == .vignette{
            vignetteView.removeFromSuperview()
        }
        if textureMode != .texture{
            textureView = UIView(frame: CGRect(x: 0, y: buttonDistance(self.containerView.frame.size.height-(HelperMethods.isIphone() ? 130 : 180),1.0,self.containerView.frame.size.height/2)+(HelperMethods.isIphone() ? 130 : 180), width: self.view.frame.size.width, height: self.containerView.frame.size.height/2))
            textureView.backgroundColor=UIColor.yellow
            containerView.addSubview(textureView)
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            //layout.itemSize = CGSize(width: 10, height: 10)
            layout.scrollDirection = .horizontal
            bottomCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.textureView.frame.width, height: self.textureView.frame.height), collectionViewLayout: layout)
            bottomCollectionView.dataSource = self
            bottomCollectionView.delegate = self
            
            bottomCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
            bottomCollectionView.allowsMultipleSelection=false
            bottomCollectionView.backgroundColor = UIColor.white
            bottomCollectionView.showsHorizontalScrollIndicator = false
            textureView.addSubview(bottomCollectionView)
        }
        textureMode = .texture
    }
    
    func createContourView(){
        if textureMode == .texture{
            textureView.removeFromSuperview()
        }
        else if textureMode == .vignette{
            vignetteView.removeFromSuperview()
        }
        if textureMode != .contour{
            contourView = UIView(frame: CGRect(x: 0, y: buttonDistance(self.containerView.frame.size.height-(HelperMethods.isIphone() ? 130 : 180),1.0,self.containerView.frame.size.height/2)+(HelperMethods.isIphone() ? 130 : 180)/*self.containerView.frame.size.height/2*/, width: self.view.frame.size.width, height: self.containerView.frame.size.height/2))
            contourView.backgroundColor=UIColor.white
            containerView.addSubview(contourView)
            
            let contourButton1 = UIButton(frame: CGRect(x: buttonDistance(self.view.frame.size.width,3.0,textureButtonHeight), y: buttonDistance(self.contourView.frame.size.height,1.0,textureButtonHeight), width: textureButtonHeight, height: textureButtonHeight))
            contourButton1.backgroundColor=UIColor.red
            contourButton1.setImage(#imageLiteral(resourceName: "white"), for: .normal)
            contourButton1.addTarget(self, action: #selector(self.contourEffect(_:)), for: .touchUpInside)
            contourButton1.tag=1
            contourView.addSubview(contourButton1)
            let contourButton2 = UIButton(frame: CGRect(x: 2*buttonDistance(self.view.frame.size.width,3.0,textureButtonHeight)+textureButtonHeight, y: buttonDistance(self.contourView.frame.size.height,1.0,textureButtonHeight), width: textureButtonHeight, height: textureButtonHeight))
            contourButton2.backgroundColor=UIColor.red
            contourButton2.setImage(#imageLiteral(resourceName: "green"), for: .normal)
            contourButton2.addTarget(self, action: #selector(self.contourEffect(_:)), for: .touchUpInside)
            contourButton2.tag=2
            contourView.addSubview(contourButton2)
            let contourButton3 = UIButton(frame: CGRect(x: 3*buttonDistance(self.view.frame.size.width,3.0,textureButtonHeight)+2*textureButtonHeight, y: buttonDistance(self.contourView.frame.size.height,1.0,textureButtonHeight), width: textureButtonHeight, height: textureButtonHeight))
            contourButton3.backgroundColor=UIColor.red
            contourButton3.setImage(#imageLiteral(resourceName: "black"), for: .normal)
            contourButton3.addTarget(self, action: #selector(self.contourEffect(_:)), for: .touchUpInside)
            contourButton3.tag=3
            contourView.addSubview(contourButton3)
        }
        
        textureMode = .contour
    }
    func createVignetteView(){
        if textureMode == .contour{
            contourView.removeFromSuperview()
        }
        else if textureMode == .texture{
            textureView.removeFromSuperview()
        }
        if textureMode != .vignette{
            vignetteView = UIView(frame: CGRect(x: 0, y: buttonDistance(self.containerView.frame.size.height-(HelperMethods.isIphone() ? 130 : 180),1.0,self.containerView.frame.size.height/2)+(HelperMethods.isIphone() ? 130 : 180), width: self.view.frame.size.width, height: self.containerView.frame.size.height/2))
            vignetteView.backgroundColor=UIColor.white
            containerView.addSubview(vignetteView)
            
            let vintageSlider = UISlider(frame: CGRect(x: 20, y: self.vignetteView.frame.size.height/2-20, width: self.vignetteView.frame.size.width-40, height: 40))
            //opacitySlider.center = vignetteView.center
            vignetteView.addSubview(vintageSlider)
            vintageSlider.minimumValue = 0
            vintageSlider.maximumValue = 1
            vintageSlider.value = Float(vintageSliderValue)
            vintageSlider.tintColor = UIColor.gray
            vintageSlider.addTarget(self, action: #selector(self.vintageSliderValueDidChange(_:)), for: .valueChanged)
        }
        textureMode = .vignette
    }
    
    
    func contourEffect(_ sender: UIButton){
        if sender.tag==1{
            contoureName = contourList.none
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
        }
        else if sender.tag==2{
            contoureName = contourList.white
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
        }
        else{
            contoureName = contourList.black
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
        }
        
        
    }
    func vintageSliderValueDidChange (_ sender: UISlider) {
        
        vintageSliderValue=CGFloat(sender.value)
        coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
    }
    var selectedIndex:Foundation.IndexPath!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
         if selectedIndex != indexPath && indexPath.row==0{
            textureName = textureList.none
             coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
         else if selectedIndex != indexPath && indexPath.row==1{
            textureName = textureList.knit
             coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
         else if selectedIndex != indexPath && indexPath.row==2{
            textureName = textureList.leath
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
         else if selectedIndex != indexPath && indexPath.row==3{
            textureName = textureList.stonwall
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
         else if selectedIndex != indexPath && indexPath.row==4{
            textureName = textureList.wallred2
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
         else if selectedIndex != indexPath && indexPath.row==5{
            textureName = textureList.wallred
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
         else if selectedIndex != indexPath && indexPath.row==6{
            textureName = textureList.wallwhit
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
         else if selectedIndex != indexPath && indexPath.row==7{
            textureName = textureList.wall
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
         else if selectedIndex != indexPath && indexPath.row==8{
            textureName = textureList.wood1
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
         else if selectedIndex != indexPath && indexPath.row==9{
            textureName = textureList.wood
            coloredImageView.image = HelperMethods.customFilters(image: coloredImage, pureImage: coloredImageNew, contourName: contoureName, textureName: textureName, size: coloredImageView.frame.size, sliderValue: vintageSliderValue)
         }
        
        selectedIndex=indexPath
        collectionView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        selectedIndex=nil
        collectionView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: textureButtonHeight, height: textureButtonHeight)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        for view in cell.subviews{
            view.removeFromSuperview()
        }
        if (self.selectedIndex != nil && indexPath == self.selectedIndex) {
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = UIColor.black.cgColor
        }else {
            cell.layer.borderWidth = 0.0
            cell.layer.borderColor = UIColor.clear.cgColor
        }
        cell.backgroundColor = UIColor.init(red: 0.55, green: 0.55, blue: 0.6, alpha: 1)
        let textureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
        if indexPath.row==0{
            textureImageView.image = #imageLiteral(resourceName: "white")
        }
        else if indexPath.row==1{
            textureImageView.image = #imageLiteral(resourceName: "knitted")
        }
        else if indexPath.row==2{
            textureImageView.image = #imageLiteral(resourceName: "leather")
        }
        else if indexPath.row==3{
            textureImageView.image = #imageLiteral(resourceName: "Stone-Wall")
        }
        else if indexPath.row==4{
            textureImageView.image = #imageLiteral(resourceName: "wall-red-brick-2")
        }
        else if indexPath.row==5{
            textureImageView.image = #imageLiteral(resourceName: "wall-red-brick")
        }
        else if indexPath.row==6{
            textureImageView.image = #imageLiteral(resourceName: "wall-white")
        }
        else if indexPath.row==7{
            textureImageView.image = #imageLiteral(resourceName: "wall")
        }
        else if indexPath.row==8{
            textureImageView.image = #imageLiteral(resourceName: "wood-1")
        }
        else if indexPath.row==9{
            textureImageView.image = #imageLiteral(resourceName: "wood")
        }
        
        
        cell.addSubview(textureImageView)
        return cell
    }
    
}

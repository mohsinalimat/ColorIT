//
//  MoreViewController.swift
//  Cut and Paste Photo
//
//  Created by Odyssey Apps on 8/23/17.
//  Copyright © 2017 Odyssey Apps. All rights reserved.
//

import UIKit
import FSPagerView

class MoreViewController: UIViewController , FSPagerViewDataSource , FSPagerViewDelegate {
    
    /*
     @IBOutlet weak var pagerView: FSPagerView! {
     didSet {
     self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
     }
     }
     
     */
    var reachability: Reachability?
    var buttonBool:Int!
    var IAPNetCheckBool:Int!
    
    func crossButtonAction() {
        
        //navigationController?.popViewController(animated: true )
        self.dismiss(animated: true, completion: nil)
        print("okaoakaoka")
    }
    //helloo
    //hello
    
    let iPhoneImages = [ #imageLiteral(resourceName: "promoImage1") , #imageLiteral(resourceName: "promoImage2") , #imageLiteral(resourceName: "promoImage3") , #imageLiteral(resourceName: "promoImage4") , #imageLiteral(resourceName: "promoImage5") ]
    let iPhoneUrls = [ "https://itunes.apple.com/US/app/id979588667" , "https://itunes.apple.com/US/app/id993420685" , "https://itunes.apple.com/US/app/id1212839079" , "https://itunes.apple.com/US/app/id1191313662" , "https://itunes.apple.com/US/app/id1237148635" ]
    let iPadImages = [ #imageLiteral(resourceName: "promoImage1") , #imageLiteral(resourceName: "promoImage2") , #imageLiteral(resourceName: "promoImage3") , #imageLiteral(resourceName: "promoImage4") , #imageLiteral(resourceName: "promoImage5") ]
    let iPadUrls = ["https://itunes.apple.com/US/app/id979588667" , "https://itunes.apple.com/US/app/id993420685" , "https://itunes.apple.com/US/app/id1212839079" , "https://itunes.apple.com/US/app/id1191313662" , "https://itunes.apple.com/US/app/id1237148635"  ]
    
    let images = [ #imageLiteral(resourceName: "promoImage1") , #imageLiteral(resourceName: "promoImage2") , #imageLiteral(resourceName: "promoImage3")]
    let names =  ["a","b","c"]
    //hello
    
    let urls = ["https://itunes.apple.com/US/app/id979588667","https://goo.gl/3a47ie","https://goo.gl/4JRW5J"]
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupReachability(useHostName: false, useClosures: true)
        self.startNotifier()
        navigationController?.isNavigationBarHidden = false
        navigationController?.automaticallyAdjustsScrollViewInsets = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let missingName : String? = "folk"
        let realName : String? = "John Doe"
        let existentName : String = missingName ?? realName!
        print(existentName)
        print("hello")
        // Create a pager view
        let pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        if (UIDevice.current.userInterfaceIdiom == .phone){
            pagerView.interitemSpacing = 10
            pagerView.itemSize = CGSize(width: 250, height: 444)
        }
        else{
            pagerView.interitemSpacing = 20
            pagerView.itemSize = CGSize(width: 400, height: 711)
        }
        
        self.view.addSubview(pagerView)
        // Create a page control
        //        let pageControl = FSPageControl(frame: CGRect(x: 0, y: 500, width: 300, height: 50))
        //        self.view.addSubview(pageControl)
        //        pageControl.numberOfPages = 5
        //        pageControl.currentPage = 1
        //        pageControl.contentHorizontalAlignment = .right
        //
        //
        //        pageControl.setStrokeColor(.green, for: .normal)
        //        pageControl.setStrokeColor(.yellow, for: .selected)
        //
        //
        //
        //
        //        pageControl.setFillColor(.gray, for: .normal)
        //        pageControl.setFillColor(.white, for: .selected)
        //
        //
        //        //pageControl.setImage(UIImage(named:"image1"), for: .normal)
        //        //pageControl.setImage(UIImage(named:"image2"), for: .selected)
        //
        //        pageControl.setPath(UIBezierPath(rect: CGRect(x: 0, y: 0, width: 8, height: 8)), for: .normal)
        //        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 8, height: 8)), for: .normal)
        pagerView.transformer = FSPagerViewTransformer(type: .coverFlow)
        
        // Do any additional setup after loading the view.
        //UIApplication.shared.openURL(URL(string : "https://goo.gl/9Vp4Fj")!)
        
        
        
        let crossButton = UIButton()
        crossButton.frame = CGRect(x: self.view.frame.width - 40 , y: 0, width: 40, height: 40)
        crossButton.addTarget(self, action: #selector(crossButtonAction), for: .touchDown)
        crossButton.titleLabel?.text = "Cross"
        //crossButton.currentTitleColor = UIColor.black
        //crossButton.backgroundColor = UIColor.lightGray
        crossButton.setImage(#imageLiteral(resourceName: "cross.png"), for: .normal)
        self.view.addSubview(crossButton)
    }
    
    
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        if (UIDevice.current.userInterfaceIdiom == .phone)
        {
            return iPhoneImages.count
        }
        else
        {
            return iPadImages.count
        }
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if (UIDevice.current.userInterfaceIdiom == .phone)
        {
            cell.imageView?.image = iPhoneImages[index]
        }
        else
        {
            cell.imageView?.image = iPadImages[index]
        }
        //cell.imageView?.image = images[index]
        //cell.textLabel?.text = names[index]
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool
    {
        return true
    }
    
    
    
    func pagerView(_ pagerView: FSPagerView, didHighlightItemAt index: Int)
    {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldSelectItemAt index: Int) -> Bool
    {
        if self.IAPNetCheckBool == 1{
            
            if (UIDevice.current.userInterfaceIdiom == .phone){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string :iPhoneUrls[index])!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string :iPhoneUrls[index])!)
                }
            }
            else{
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string :iPadUrls[index])!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string :iPadUrls[index])!)
                }
            }
            
            
        }
        else{
            UIAlertView(title: NSLocalizedString("No internet connection!!", comment: "title"),
                        message: NSLocalizedString("You have to be connected with internet data connection to access this option.", comment: "title"),
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
            
            
        }
        
        return false
    }
    
    public func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int)
    {
        
        //print("something")
        
    }
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int)
    {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int)
    {
        
    }
    func pagerViewWillBeginDragging(_ pagerView: FSPagerView)
    {
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int)
        
    {
        
    }
    func pagerViewDidScroll(_ pagerView: FSPagerView)
    {
        
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView)
        
    {
        
    }
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView)
        
    {
        
    }
    
    //INTERNET CONNECTION CHECK
    
    func setupReachability(useHostName: Bool, useClosures: Bool) {
        let hostName = "google.com"
        //        hostNameLabel.text = useHostName ? hostName : "No host name"
        //
        //        print("--- set up with host name: \(hostNameLabel.text!)")
        
        let reachability = useHostName ? Reachability(hostname: hostName) : Reachability()
        self.reachability = reachability
        
        if useClosures {
            reachability?.whenReachable = { reachability in
                self.updateLabelColourWhenReachable(reachability)
            }
            reachability?.whenUnreachable = { reachability in
                self.updateLabelColourWhenNotReachable(reachability)
            }
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(NewViewController.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
        }
    }
    
    
    func startNotifier() {
        print("--- start notifier")
        do {
            try reachability?.startNotifier()
        } catch {
            //            networkStatus.textColor = .red
            //            networkStatus.text = "Unable to start\nnotifier"
            
            return
        }
    }
    
    func stopNotifier()
    {
        print("--- stop notifier")
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        reachability = nil
    }
    
    
    
    func updateLabelColourWhenReachable(_ reachability: Reachability) {
        print("\(reachability.description) - \(reachability.currentReachabilityString)")
        
        IAPNetCheckBool = 1
        
        if reachability.isReachableViaWiFi {
            
        }
        else {
            
        }
        
    }
    
    
    
    func updateLabelColourWhenNotReachable(_ reachability: Reachability) {
        print("\(reachability.description) - \(reachability.currentReachabilityString)")
        IAPNetCheckBool = 2
        //        self.networkStatus.textColor = .red
        
        //        self.networkStatus.text = reachability.currentReachabilityString
        //        internetStatusView.isHidden = false
        
        if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
            DispatchQueue.main.async {
                
                // Alert Box
                let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use ColoringBook in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                //        alert.popoverPresentationController?.sourceView = self.view
                //        alert.popoverPresentationController?.sourceRect = CGRect(x: sSize.width*0.9, y: sSize.height - bottomSpace*0.85, width: 0, height: 0)
                
                
                
                
                
                // create IAP option
                let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: $2.99", comment: "title"), style: .default) {(UIAlerAction) -> Void in
                    
                    
                    //            print("0")
                    //            print("iapProducts[0]======\(self.iapProducts[0])")
                    //            self.purchaseMyProduct(product: self.iapProducts[0])
                    
                    
                    UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                delegate: nil,
                                cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    
                    
                }
                alert.addAction(iapAction)
                
                
                
                // Cancel Action
                let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                
                
                
                
                //        // create Restore option
                //        let restoreAction = UIAlertAction(title: "Restore Purchase", style: .default) {(UIAlerAction) -> Void in
                //
                //
                //            print("2")
                //
                //            SKPaymentQueue.default().add(self)
                //            SKPaymentQueue.default().restoreCompletedTransactions()
                //
                //
                //
                //        }
                //        alert.addAction(restoreAction)
                
                
                
                
                
                //Present Alert Controller
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
    }
    
    
    func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            updateLabelColourWhenReachable(reachability)
        } else {
            updateLabelColourWhenNotReachable(reachability)
        }
    }
    
    
    deinit {
        stopNotifier()
    }
    
    
}

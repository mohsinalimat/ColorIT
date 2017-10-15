//
//  NewViewController.swift
//  ColoringBook
//
//  Created by Admin on 2017-09-25.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import UIKit
import FSPagerView
import StoreKit
import MessageUI


class NewViewController: UIViewController , UIScrollViewDelegate , FSPagerViewDataSource,FSPagerViewDelegate , UITableViewDelegate , UITableViewDataSource , SKProductsRequestDelegate, SKPaymentTransactionObserver , MFMailComposeViewControllerDelegate{
    
    // MARK: - Reachability
    func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            //updateLabelColourWhenReachable(reachability)
        } else {
            //updateLabelColourWhenNotReachable(reachability)
        }
    }
    
    var test = 10
    static var selfCopy = NewViewController()
    // MARK: - Outlets Upper View
    @IBOutlet var upperViewHolder: UIView!
    let scrollView = FSPagerView()
    @IBOutlet var upDownButton: UIButton!
    @IBOutlet var deleteMyArtWorkButton: UIButton!
    
    // MARK: - Outlets Down View
    @IBOutlet var downViewHolder: UIView!

    let tableView = UITableView()
    
   var myArtWork = [Draft]()
    
    
    
   
    // MARK: - Frame Copies Outlets
    var upperViewHolderFrameCopy = CGRect()
    var downViewHolderFrameCopy = CGRect()
    
    // MARK: - Data Sources Outlets and Actions
    var startingImages = [#imageLiteral(resourceName: "Birds1.png"),#imageLiteral(resourceName: "Birds2.png"),#imageLiteral(resourceName: "Culture1.png"),#imageLiteral(resourceName: "Culture2.png")]
    var dataDictionary = [String : [UIImage]]()
    func buildDataDictionary()
    {  // "Birds","Animals","Fashion","Culture","Christmas","Comics"
        let birdsImages = [#imageLiteral(resourceName: "Birds1.png"),#imageLiteral(resourceName: "Birds2.png")]
        let animalImages = [#imageLiteral(resourceName: "Animals1.png"),#imageLiteral(resourceName: "Animals2.png")]
        let fasionImages = [#imageLiteral(resourceName: "Fashion1.png"),#imageLiteral(resourceName: "Fashion2.png"),#imageLiteral(resourceName: "Fashion3.png")]
        let cultureImages = [#imageLiteral(resourceName: "Culture1.png"),#imageLiteral(resourceName: "Culture2.png"),#imageLiteral(resourceName: "Culture3.png"),#imageLiteral(resourceName: "Culture4.png"),#imageLiteral(resourceName: "Culture5.png"), #imageLiteral(resourceName: "Culture6.png")]
        let christmasImages = [#imageLiteral(resourceName: "Christmas1.png"),#imageLiteral(resourceName: "Christmas2.png"),#imageLiteral(resourceName: "Christmas3.png"),#imageLiteral(resourceName: "Christmas4.png"),#imageLiteral(resourceName: "Christmas5.png")]
        let comoicsImages = [#imageLiteral(resourceName: "shutterstock_390780931-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_327716645-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_328071368-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_396296125-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_449997736-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_398779984-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_285644417-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_389612521-[Converted].png"),#imageLiteral(resourceName: "shutterstock_496343161-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_478145179-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_400313902-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_450844078-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_281143067-[Converted]1xx.jpg"),#imageLiteral(resourceName: "Comics2.png")]
        
        dataDictionary["Birds"] = birdsImages
        dataDictionary["Animals"] = animalImages
        dataDictionary["Fashion"] = fasionImages
        dataDictionary["Culture"] = cultureImages
        dataDictionary["Christmas"] = christmasImages
        dataDictionary["Comics"] = comoicsImages
    }
    
    
    // MARK: - Action Methods in Upper View
    
    @IBAction func upDownButtonAction(_ sender: UIButton, forEvent event: UIEvent)
    {
       
        
            if self.upperViewHolder.center.y > self.view.frame.minY
            {
                // If downViewHolder at down .
                
                
                    UIView.animate(withDuration: 0.5 , animations: {
                        self.upperViewHolder.frame = CGRect(x: 0, y: 150 - self.upperViewHolderFrameCopy.height , width: self.upperViewHolderFrameCopy.width, height: self.upperViewHolderFrameCopy.height)
                        self.downViewHolder.frame = CGRect(x: 0, y: 150 , width: self.downViewHolderFrameCopy.width, height: self.downViewHolderFrameCopy.height)
                    } , completion :{(_:Bool) in
                        UIView.animate(withDuration: 0.25) {
                            self.upDownButton.rotate(angle: 180)
                        }
                    })
                
                
                
            }
            else
            {
                // If downViewHolder at top .
                
                
                UIView.animate(withDuration: 0.5 , animations: {
                    self.upperViewHolder.frame = CGRect(x: 0, y: 0 , width: self.upperViewHolderFrameCopy.width, height: self.upperViewHolderFrameCopy.height)
                    self.downViewHolder.frame = CGRect(x: 0, y: self.downViewHolderFrameCopy.minY , width: self.downViewHolderFrameCopy.width, height: self.downViewHolderFrameCopy.height)
                    
                } , completion :{(_:Bool) in
                    UIView.animate(withDuration: 0.25) {
                        self.upDownButton.rotate(angle: 180)
                    }})
            }
        
        
       
        
    }
    
    
    @IBAction func colorItButtonAction(_ sender: UIButton, forEvent event: UIEvent)
    {
        
        pagerView(scrollView, didSelectItemAt: scrollView.currentIndex)
      
        /* OLD
        
            if self.upperViewHolder.center.y < self.view.frame.minY
            {
                // If downViewHolder at down .
                
                print("here")
                UIView.animate(withDuration: 0.5 , animations: {
                    self.upperViewHolder.frame = CGRect(x: 0, y: 0 , width: self.upperViewHolderFrameCopy.width, height: self.upperViewHolderFrameCopy.height)
                    self.downViewHolder.frame = CGRect(x: 0, y: self.downViewHolderFrameCopy.minY , width: self.downViewHolderFrameCopy.width, height: self.downViewHolderFrameCopy.height)
                    
                } , completion :{(_:Bool) in
                    UIView.animate(withDuration: 0.25, animations:{
                        self.upDownButton.rotate(angle: 180)
                    } ,completion : {(_:Bool)in self.performSegue(withIdentifier: "toColor", sender: self) })
                
                })
            
            }
            else
            {
                performSegue(withIdentifier: "toColor", sender: self)
            }
        
    
        //performSegue(withIdentifier: "toColor", sender: self)
        
        
    */
    }
    
    
    
    @IBAction func deleteButtonAction(_ sender: UIButton)
    {
        
        if myArtWork.count != 0
        {
            let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
            let data = context.object(with: myArtWork[scrollView.currentIndex].objectID) as? Draft
            context.delete(data!)
            
            
            do
            {
                try context.save()
                let database = DataMGMT.extractImagesFromDraft()
                
                startingImages = database.images
                myArtWork = database.data
                
                self.scrollView.reloadData()
            
               
                
            } catch let error as NSError {
                // failure
                print(error)
            }

        }
        
        

        
    }
    
    
    
    // MARK: -  Outlets & Action Methods in Down View
    
    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var button4: UIButton!
    
    var menuDidSelected = true
    
    func prepareButtons(forButtonNo selectedIndex : Int)
    {
        
        
            
            if selectedIndex == 1
            {
                tableView.separatorColor = UIColor.lightGray
                self.menuDidSelected = true
                self.button1.backgroundColor = UIColor.white
                self.button2.backgroundColor = UIColor.lightGray
                self.button3.backgroundColor = UIColor.lightGray
                self.button4.backgroundColor = UIColor.lightGray
                
            }
            else if selectedIndex == 2
            {
                //tableView.separatorColor = UIColor.clear
                self.menuDidSelected = false
                self.button1.backgroundColor = UIColor.lightGray
                self.button2.backgroundColor = UIColor.white
                self.button3.backgroundColor = UIColor.lightGray
                self.button4.backgroundColor = UIColor.lightGray
                
            }
        
        
    }
    
    @IBAction func button1Action(_ sender: UIButton, forEvent event: UIEvent)
    {
        prepareButtons(forButtonNo: 1)
        menuDidSelected = true
        tableView.reloadData()
    }
    @IBAction func button2Action(_ sender: Any, forEvent event: UIEvent)
    {
        prepareButtons(forButtonNo: 2)
        menuDidSelected = false
        tableView.reloadData()
    }
    @IBAction func button3Action(_ sender: UIButton, forEvent event: UIEvent)
    {
        
    }
    @IBAction func button4Action(_ sender: UIButton, forEvent event: UIEvent)
    {
        performSegue(withIdentifier: "toMore", sender: self)
        
        if self.upperViewHolder.center.y < self.view.frame.minY
        {
            // If downViewHolder at down .
            /*
            print("here")
            UIView.animate(withDuration: 0.5 , animations: {
                self.upperViewHolder.frame = CGRect(x: 0, y: 0 , width: self.upperViewHolderFrameCopy.width, height: self.upperViewHolderFrameCopy.height)
                self.downViewHolder.frame = CGRect(x: 0, y: self.downViewHolderFrameCopy.minY , width: self.downViewHolderFrameCopy.width, height: self.downViewHolderFrameCopy.height)
                
            } , completion :{(_:Bool) in
                UIView.animate(withDuration: 0.25, animations:{
                    self.upDownButton.rotate(angle: 180)
                } ,completion : {(_:Bool)in self.performSegue(withIdentifier: "toMore", sender: self) })
                
            })
            
            */
            
        }
        else
        {
            performSegue(withIdentifier: "toMore", sender: self)
        }
    }
    
    
    
    
    
    // MARK: - Setting Up Upper View Holder
    
    func setupUpperViewHolder()
    {
        upperViewHolder.frame =  self.view.frame
        upperViewHolderFrameCopy = upperViewHolder.frame // Need for animation
        setupScrollView()
        deleteMyArtWorkButton.isHidden  = true
        
    }
    
    func setupScrollView()
    {
        let screenSize = UIScreen.main.bounds
        
        scrollView.frame.size = CGSize(width: screenSize.width, height: screenSize.width)
        //scrollView.backgroundColor = UIColor.black
        scrollView.center = upperViewHolder.center //CGPoint(x: screenSize.width/2 , y: screenSize.height/2)
        scrollView.dataSource = self
        scrollView.delegate = self
        scrollView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        scrollView.interitemSpacing = 10
        scrollView.itemSize = CGSize(width: screenSize.width - 20 , height: screenSize.width - 20)
        
        upperViewHolder.addSubview(scrollView)
        
    }
    
    
    
    // MARK: - SettingUp Down View Holder
    
    
    
    func setupDownViewHolder()
    {
        downViewHolder.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height - 150)
        downViewHolderFrameCopy = downViewHolder.frame // Need for animation
        
        // Now By Default Menu Table should be build 
        tableView.frame = CGRect(x: 0, y: 68, width: downViewHolderFrameCopy.width, height: downViewHolderFrameCopy.height - 68) // Button Height + Gray Label = 71 + 2 = 73 - 5 = 68
        tableView.dataSource = self
        tableView.delegate = self
        downViewHolder.addSubview(tableView)
        
    }
    
    // MARK: - Starting Image Picking
    var startingImagesProductKeys  = [String]()
    
    
    
    
    // MARK: - View Controller's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let missingName : String? = "folk"
        let realName : String? = "John Doe"
        let existentName : String =  realName ?? missingName!
        print(existentName)
        print("hello")
        setupUpperViewHolder()
        
        //self.extendedLayoutIncludesOpaqueBars = true
        //print(upperViewHolder.frame)
        //print(upperViewHolder.center)
        //print(self.view.center)
        
        //downViewHolder.center = CGPoint(x: 0, y: 0)
        buildDataDictionary()
        NewViewController.selfCopy = self
        self.fetchAvailableProducts()
        prepareTableLabels()
        
    }
    
    var didViewAppeared = false
    override func viewDidAppear(_ animated: Bool) {
         // Cause It works perfect here . Storyboard load here .
        if !didViewAppeared
        {   prepareButtons(forButtonNo: 1)
            setupDownViewHolder()
            didViewAppeared = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        //automaticallyAdjustsScrollViewInsets = false
        print(test)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        SKPaymentQueue.default().remove(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toColor"
        {
            test = 1
            if let target = segue.destination as? ColorViewController
            {
                target.dataImage = startingImages[scrollView.currentIndex]
                
                //target.newvc = self
                
            }
            
        }
        
        
        
    }
    
    
    
    
    
    // MARK: - FSPager View Delegates 
    
    var currentProductKey = ""
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return startingImages.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell
    {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = startingImages[index]
        //cell.textLabel?.text = "Hello Me"
        
        // Clearing previous imageview without default one
        var first = true
        for view in cell.subviews {
            if !first
            {
                view.removeFromSuperview()
            }
            else
            {
                first = false
            }
            
        }
        //--------------Clearing Imageviews--------------------------------------
        if (index > 0) && (currentProductKey != "Draft")
        {
            let lockImageView = UIImageView()
            lockImageView.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            lockImageView.image = #imageLiteral(resourceName: "lock2.png")
            cell.addSubview(lockImageView)
            
        }
        
        
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
        return true
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int)
    {
        if (index == 0) || (currentProductKey == "Draft")
        {
            if self.upperViewHolder.center.y < self.view.frame.minY
            {
                // If downViewHolder at down .
                
                print("here")
                UIView.animate(withDuration: 0.5 , animations: {
                    self.upperViewHolder.frame = CGRect(x: 0, y: 0 , width: self.upperViewHolderFrameCopy.width, height: self.upperViewHolderFrameCopy.height)
                    self.downViewHolder.frame = CGRect(x: 0, y: self.downViewHolderFrameCopy.minY , width: self.downViewHolderFrameCopy.width, height: self.downViewHolderFrameCopy.height)
                    
                } , completion :{(_:Bool) in
                    UIView.animate(withDuration: 0.25, animations:{
                        self.upDownButton.rotate(angle: 180)
                    } ,completion : {(_:Bool)in self.performSegue(withIdentifier: "toColor", sender: self) })
                    
                })
                
            }
            else
            {
                performSegue(withIdentifier: "toColor", sender: self)
            }
        }
        else
        {
            
            if self.upperViewHolder.center.y < self.view.frame.minY
            {
                // If downViewHolder at down .
                
                print("here")
                UIView.animate(withDuration: 0.5 , animations: {
                    self.upperViewHolder.frame = CGRect(x: 0, y: 0 , width: self.upperViewHolderFrameCopy.width, height: self.upperViewHolderFrameCopy.height)
                    self.downViewHolder.frame = CGRect(x: 0, y: self.downViewHolderFrameCopy.minY , width: self.downViewHolderFrameCopy.width, height: self.downViewHolderFrameCopy.height)
                    
                } , completion :{(_:Bool) in
                    UIView.animate(withDuration: 0.25, animations:{
                        self.upDownButton.rotate(angle: 180)
                    } ,completion : {(_:Bool) in
                        
                        //------------------------------------------------------------------------
                        if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade3") == false{
                            
                            if ReachabilityX.isConnectedToNetwork() == true
                            {
                                self.purchaseMyProduct(product: self.iapProducts[2])
                            }
                                
                            else
                            {
                                if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade3") == false
                                {
                                    DispatchQueue.main.async
                                        {
                                            
                                            // Alert Box
                                            let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                            
                                            // create IAP option
                                            let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                                
                                                
                                                UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                            message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                            delegate: nil,
                                                            cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                                
                                                
                                            }
                                            alert.addAction(iapAction)
                                            
                                            
                                            
                                            // Cancel Action
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet ", comment: "title"), style: .cancel){
                                                (UIAlerAction) -> Void in
                                                
                                                
                                                
                                            }
                                            alert.addAction(cancelAction)
                                            
                                            self.present(alert, animated: true, completion: nil)
                                            
                                    }
                                }
                                
                                
                            }
                        }
                        else{
                            
                            //print("0")
                            //purchaseMyProduct(product: iapProducts[1])
                            self.performSegue(withIdentifier: "toColor", sender: self)
                        }
                        //---------------------------------------------------------------------
                        
                    })
                    
                })
                
            }
            else
            {
                //------------------------------------------------------------------------
                if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade3") == false{
                    
                    if ReachabilityX.isConnectedToNetwork() == true
                    {
                        purchaseMyProduct(product: iapProducts[2])
                    }
                        
                    else
                    {
                        if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade3") == false
                        {
                            DispatchQueue.main.async
                                {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                        
                                        
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet ", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                            }
                        }
                        
                        
                    }
                }
                else{
                    
                    //print("0")
                    //purchaseMyProduct(product: iapProducts[1])
                    performSegue(withIdentifier: "toColor", sender: self)
                }
                //---------------------------------------------------------------------
                
            }
            
           
        }
         scrollView.deselectItem(at: index, animated: true)
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
    
    
    // MARK: - Table View Delegates and DataSources
    
    
    let menuSections = ["ARTWORKS" , "CATEGORIES"]
    let menuRow1 = ["My Artworks"]
    let menuRow1Icons = [UIImage()]
    let menuRow2 = ["Birds","Animals","Fashion","Culture","Christmas","Comics"]
    let menuRow2Icons = [#imageLiteral(resourceName: "Birds.png"),#imageLiteral(resourceName: "Animals.png"),#imageLiteral(resourceName: "Fashion.png"),#imageLiteral(resourceName: "Culture.png"),#imageLiteral(resourceName: "Christmas.png"),#imageLiteral(resourceName: "Comics.png")]
    var menu = [(rowNames : [String], rowIcons : [UIImage])]()
    
    
    
    let settingSectionHeaders = ["STORE","FEEDBACK","FOLLOW US ON"]
    let settingRow1 = ["Offline Usage + Remove Ads" , "Buy All Categories" , "Restore Purchase"]
    let settingRow1Icons = [#imageLiteral(resourceName: "Offline useage + remove ads.png"),UIImage(),#imageLiteral(resourceName: "Restore purchase.png")]
    let settingRow2 = ["Tell A Friend","Contact Us","Share App","Write A Review"]
    let settingRow2Icons = [#imageLiteral(resourceName: "tell-a-friend.png"),#imageLiteral(resourceName: "contactUs.png"),#imageLiteral(resourceName: "share-this-app.png"),#imageLiteral(resourceName: "give-us-review.png"),#imageLiteral(resourceName: "more.png")]
    let settingRow3 = ["Facebook","Twitter","Instagram","LinkedIn"]
    let settingRow3Icons = [#imageLiteral(resourceName: "Facebook.png"),#imageLiteral(resourceName: "Twitter.png"),#imageLiteral(resourceName: "Instagram.png"),#imageLiteral(resourceName: "LinkedIn.png")]
    var setting = [(rowNames : [String], rowIcons : [UIImage])]()
    
    
    
    func prepareTableLabels()
    {
        menu = [(menuRow1,menuRow1Icons),(menuRow2,menuRow2Icons)]
        setting = [(settingRow1,settingRow1Icons),(settingRow2,settingRow2Icons),(settingRow3,settingRow3Icons)]
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if !menuDidSelected
        {
            return setting.count
        }
        else
        {
           return menuSections.count
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if !menuDidSelected
        {
            return setting[section].rowNames.count
        }
        else
        {
            return menu[section].rowNames.count
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
   
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("MenuViewCell", owner: self, options: nil)?.first as! MenuViewCell
        
        if !menuDidSelected
        {
            cell.title.text = setting[indexPath.section].rowNames[indexPath.row]
            cell.icon.image = setting[indexPath.section].rowIcons[indexPath.row]
            return cell
        }
        else
        {
            
          
                let itemName = menu[indexPath.section].rowNames[indexPath.row]
                cell.title.text = itemName
                cell.icon.image = menu[indexPath.section].rowIcons[indexPath.row] //UIImage(named: itemName + ".png")
                return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !menuDidSelected
        {
            return settingSectionHeaders[section]
        }
        else
        {
            return menuSections[section]
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // MARK: - Settings Table 
        
        if !menuDidSelected
        {
            // MARK: - Section 0 : Settings Table
            if indexPath.section == 0
            {
                let row = indexPath.row
                
                // MARK: - Row 0
                if row == 0
                {
                    
                    //------------------------------------------------------------------------
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if ReachabilityX.isConnectedToNetwork() == true
                        {
                            print("Here I Am ")
                            purchaseMyProduct(product: iapProducts[0])
                        }
                            
                        else
                        {
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false
                            {
                                DispatchQueue.main.async
                                    {
                                        
                                        // Alert Box
                                        let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                        
                                        // create IAP option
                                        let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                            
                                            
                                            UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                        message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                        delegate: nil,
                                                        cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                            
                                            
                                        }
                                        alert.addAction(iapAction)
                                        
                                        
                                        
                                        // Cancel Action
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                            (UIAlerAction) -> Void in
                                            
                                            
                                            
                                        }
                                        alert.addAction(cancelAction)
                                        
                                        self.present(alert, animated: true, completion: nil)
                                        
                                }
                            }
                            
                            
                        }
                    }
                    else{
                        
                        UIAlertView(title: NSLocalizedString("Thank You !", comment: "title"),
                                    message: NSLocalizedString("This feature is already purchased .", comment: "title"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    }
                    //---------------------------------------------------------------------
                }
                    // MARK: - Row 1
                else if row == 1
                {
                    
                    //------------------------------------------------------------------------
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade2") == false{
                        
                        if ReachabilityX.isConnectedToNetwork() == true
                        {
                            purchaseMyProduct(product: iapProducts[1])
                        }
                            
                        else
                        {
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade2") == false
                            {
                                DispatchQueue.main.async
                                    {
                                        
                                        // Alert Box
                                        let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                        
                                        // create IAP option
                                        let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                            
                                            
                                            UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                        message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                        delegate: nil,
                                                        cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                            
                                            
                                        }
                                        alert.addAction(iapAction)
                                        
                                        
                                        
                                        // Cancel Action
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "title"), style: .cancel){
                                            (UIAlerAction) -> Void in
                                            
                                            
                                            
                                        }
                                        alert.addAction(cancelAction)
                                        
                                        self.present(alert, animated: true, completion: nil)
                                        
                                }
                            }
                            
                            
                        }
                    }
                    else{
                        
                        UIAlertView(title: NSLocalizedString("Thank You !", comment: "title"),
                                    message: NSLocalizedString("This feature is already purchased .", comment: "title"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    }
                    //---------------------------------------------------------------------
                    
                }
                    // MARK: - Row 2
                else if row == 2
                {
                    //---------------------------------------------------------------------------------
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if ReachabilityX.isConnectedToNetwork(){
                            
                            print("4")
                            
                            SKPaymentQueue.default().add(self)
                            SKPaymentQueue.default().restoreCompletedTransactions()
                            
                        }
                            
                        else{
                            
                            
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                                DispatchQueue.main.async {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default) {(UIAlerAction) -> Void in
                                        
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase Restoring can't be proceed without internet! You need to connect with internet and purchase restoring feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                        
                                        
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                        }
                        
                    }
                    else
                    {
                        
                        print("4")
                        if ReachabilityX.isConnectedToNetwork()
                        {
                            SKPaymentQueue.default().add(self)
                            SKPaymentQueue.default().restoreCompletedTransactions()
                        }
                        else
                        {
                            UIAlertView(title: NSLocalizedString("Sorry !", comment: "title"),
                                        message: NSLocalizedString("No internet connection vailable .", comment: "title"),
                                        delegate: nil,
                                        cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                        }
                        
                    }
                    //------------------------------------------------------------------------------
                }
            }
                // MARK: - Section 1 : Settings Table
            else if indexPath.section == 1
            {
                // MARK: - Row 0
                if indexPath.row == 0
                {
                    
                    //----------------------------------------------------------------------------
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if ReachabilityX.isConnectedToNetwork() {
                            
                            mailToTellAFriend()
                        }
                            
                        else{
                            
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                                DispatchQueue.main.async {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                        }
                        
                    }
                    else{
                        mailToTellAFriend()
                    }
                    //----------------------------------------------------------------------------

                }
                // MARK: - Row 1
                if indexPath.row == 1{
                    
                    //----------------------------------------------------------------------------
                    
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if ReachabilityX.isConnectedToNetwork() == true{
                            
                            mail()
                        }
                            
                        else{
                            
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                                DispatchQueue.main.async {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                        }
                        
                    }
                    else{
                        mail()
                    }
                }
                
                //---------------------------------------------------------------------------------
                // MARK: - Row 2
                if indexPath.row == 2{
                    
                    
                    
                    //-------------------------------------------------------
                    
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if ReachabilityX.isConnectedToNetwork() == true{
                            
                            //                        let someText:String = "Try this amazing SCANNER app and save your time by scanning & managing all your documents."
                            DispatchQueue.main.async(execute: {
                                let objectsToShare:URL = URL(string: "https://itunes.apple.com/US/app/id1201209424")!
                                let sharedObjects:[AnyObject] = [objectsToShare as AnyObject]
                                let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
                                self.present(activityViewController, animated: true, completion: nil)
                            })
                        }
                            
                        else{
                            
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                                DispatchQueue.main.async {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    else{
                        DispatchQueue.main.async(execute: {
                            //                    let someText:String = "Try this amazing SCANNER app and save your time by scanning & managing all your documents"
                            let objectsToShare:URL = URL(string: "https://itunes.apple.com/US/app/id1201209424")!
                            let sharedObjects:[AnyObject] = [objectsToShare as AnyObject]
                            let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
                            self.present(activityViewController, animated: true, completion: nil)
                        })
                        
                    }
                    
                    //------------------------------------------------------------------
                }
                // MARK: - Row 3
                if indexPath.row == 3{
                    
                    //-------------------------------------------------------------------
                    
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if  ReachabilityX.isConnectedToNetwork(){
                            
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(URL(string : "https://itunes.apple.com/us/app/id1262745364")!, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(URL(string : "https://itunes.apple.com/us/app/id1262745364")!)
                            }
                        }
                            
                        else{
                            
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                                DispatchQueue.main.async {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                        
                                        
                                        
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                        }
                        
                    }
                    else{
                        
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string : "https://itunes.apple.com/us/app/id1262745364")!, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL(string : "https://itunes.apple.com/us/app/id1262745364")!)
                        }
                    }
                    //-------------------------------------------------------------------
                }


            }
                        // MARK: - Section 2 : Settings Table
            if indexPath.section == 2
            {
                // MARK: - Row 0
                if indexPath.row == 0{
                    
                    //---------------------------------------------------------------------------
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if ReachabilityX.isConnectedToNetwork() == true{
                            
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(URL(string : "https://www.facebook.com/Odyssey-Apps-Ltd-1430982826963290/")!, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(URL(string : "https://www.facebook.com/Odyssey-Apps-Ltd-1430982826963290/")!)
                            }
                            
                        }
                            
                        else{
                            
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                                DispatchQueue.main.async {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                        
                                        
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                        }
                        
                    }
                    else{
                        
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string : "https://www.facebook.com/Odyssey-Apps-Ltd-1430982826963290/")!, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL(string : "https://www.facebook.com/Odyssey-Apps-Ltd-1430982826963290/")!)
                        }
                        
                    }
                    
                    
                 //--------------------------------------------------------------------------------
                }
                
                // MARK: - Row 1
                if indexPath.row == 1{
                    
                    //---------------------------------------------------------------------------
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if ReachabilityX.isConnectedToNetwork() == true{
                            
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(URL(string : "https://twitter.com/odysseyappsltd")!, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(URL(string : "https://twitter.com/odysseyappsltd")!)
                            }
                            
                        }
                            
                        else{
                            
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                                DispatchQueue.main.async {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                        
                                        
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                        }
                        
                    }
                    else{
                        
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string : "https://twitter.com/odysseyappsltd")!, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL(string : "https://twitter.com/odysseyappsltd")!)
                        }
                        
                    }
                    
                    
                    //--------------------------------------------------------------------------------
                }
                // MARK: - Row 2
                if indexPath.row == 2{
                    
                    //---------------------------------------------------------------------------
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if ReachabilityX.isConnectedToNetwork() == true{
                            
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(URL(string : "https://www.instagram.com/odysseyapps/?hl=en")!, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(URL(string : "https://www.instagram.com/odysseyapps/?hl=en")!)
                            }
                            
                        }
                            
                        else{
                            
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                                DispatchQueue.main.async {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                        
                                        
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                        }
                        
                    }
                    else{
                        
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string : "https://www.instagram.com/odysseyapps/?hl=en")!, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL(string : "https://www.instagram.com/odysseyapps/?hl=en")!)
                        }
                        
                    }
                    
                    
                    //--------------------------------------------------------------------------------
                }
                // MARK: - Row 3
                if indexPath.row == 3{
                    
                    //---------------------------------------------------------------------------
                    if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                        
                        if ReachabilityX.isConnectedToNetwork() == true{
                            
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(URL(string : "https://www.linkedin.com/company/13280895/")!, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(URL(string : "https://www.linkedin.com/company/13280895/")!)
                            }
                            
                        }
                            
                        else{
                            
                            if UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1") == false{
                                DispatchQueue.main.async {
                                    
                                    // Alert Box
                                    let alert = UIAlertController(title: NSLocalizedString("USE OFFLINE?", comment: "title"), message:NSLocalizedString("You can use Coloring Book in Offline now & remove all the annoying Advertisement forever!", comment: "title"), preferredStyle: .alert )
                                    
                                    // create IAP option
                                    let iapAction = UIAlertAction(title: NSLocalizedString("Offline Usage + Remove Ads: 2.99", comment: "title"), style: .default){(UIAlerAction) -> Void in
                                        
                                        
                                        UIAlertView(title: NSLocalizedString("No Internet Connection!", comment: "title"),
                                                    message: NSLocalizedString("Purchase can't be made without internet! You need to connect with internet and purchase feature from store option", comment: "title"),
                                                    delegate: nil,
                                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                                        
                                        
                                    }
                                    alert.addAction(iapAction)
                                    
                                    
                                    
                                    // Cancel Action
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Use Internet", comment: "title"), style: .cancel){
                                        (UIAlerAction) -> Void in
                                        
                                        
                                        
                                    }
                                    alert.addAction(cancelAction)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                        }
                        
                    }
                    else{
                        
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string : "https://www.linkedin.com/company/13280895/")!, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL(string : "https://www.linkedin.com/company/13280895/")!)
                        }
                        
                    }
                    
                    
                    //--------------------------------------------------------------------------------
                }
            }
            
            
            
            

        }
        // MARK: - Menu Table
        else
        {
            // For Menu
            if indexPath.section == 0 // My ArtWorks
            {
                if indexPath.row == 0
                {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.deleteMyArtWorkButton.isHidden = false
                    })
                    DispatchQueue.main.async {
                        let dataBase = DataMGMT.extractImagesFromDraft()
                        self.startingImages = dataBase.images
                        self.myArtWork = dataBase.data
                        self.currentProductKey = "Draft"
                        self.scrollView.reloadData()
                        self.upDownButtonAction(UIButton(), forEvent: UIEvent())
                    }
                }
            }
            else if indexPath.section == 1 // Rest All
            {
                UIView.animate(withDuration: 0.3, animations: { 
                    self.deleteMyArtWorkButton.isHidden = true
                })
                
                startingImages =  dataDictionary[menu[indexPath.section].rowNames[indexPath.row]]!
                currentProductKey = "nonConsumablePurchaseMade\(indexPath.row + 3)"
                // First Category Product key is "nonConsumablePurchaseMade3"
                
                self.scrollView.reloadData()
                upDownButtonAction(UIButton(), forEvent: UIEvent())
            }
        }
    }
    
    
    // MARK: - IAP Delegates and Variables
    
    /* InApp Variables */
    let removeAdsOfflineUsage = "id1"
    let unlockAllCategories = "id2"
    let unlockBirds = "id2"
    let unlockAnimals = "id3"
    let unlockFashion = "id4"
    let unlockCulture = "id5"
    let unlockChristmas  = "id6"
    let unlockComics = "id7"
    
    
    
    /* Delegate Variables */
    var productID = ""
    var productsRequest = SKProductsRequest()
    var iapProducts = [SKProduct]()
    
    /* User Default Variables */
    var nonConsumablePurchaseMade1 = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade1")
    var nonConsumablePurchaseMade2 = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade2")
    var nonConsumablePurchaseMade3 = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade3")
    var nonConsumablePurchaseMade4 = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade4")
    var nonConsumablePurchaseMade5 = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade5")
    var nonConsumablePurchaseMade6 = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade6")
    var nonConsumablePurchaseMade7 = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade7")
    var nonConsumablePurchaseMade8 = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade8")
    
    // MARK: - FETCH AVAILABLE IAP PRODUCTS
    func fetchAvailableProducts()  {
        print("func fetchAvailableProducts()")
        // Put here your IAP Products ID's
        let productIdentifiers = NSSet(objects:
            removeAdsOfflineUsage, unlockAllCategories , unlockBirds, unlockAnimals ,unlockFashion,unlockCulture,unlockChristmas,unlockComics
        )
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        print("func paymentQueueRestoreCompletedTransactionsFinished")
        print("queue.transactions======\(queue.transactions)")
        print("queue.transactions.count======\(queue.transactions.count)")
        
        var atleastOneProductDidRestored = false
        for transaction in queue.transactions{
            
            print("transaction======\(transaction)")
            if(transaction.transactionState == SKPaymentTransactionState.restored){
                atleastOneProductDidRestored = true
                print("transaction.transactionState========\(transaction.transactionState)")
                
                
                if transaction.payment.productIdentifier==removeAdsOfflineUsage{
                    nonConsumablePurchaseMade1 = true
                    UserDefaults.standard.set(nonConsumablePurchaseMade1, forKey: "nonConsumablePurchaseMade1")
                    
                }
                    
                else if transaction.payment.productIdentifier==unlockAllCategories{
                    nonConsumablePurchaseMade2 = true
                    UserDefaults.standard.set(nonConsumablePurchaseMade2, forKey: "nonConsumablePurchaseMade2")
                    
                }
                else if transaction.payment.productIdentifier=="id3"{
                    nonConsumablePurchaseMade3 = true
                    UserDefaults.standard.set(nonConsumablePurchaseMade3, forKey: "nonConsumablePurchaseMade3")
                    
                }
                else if transaction.payment.productIdentifier=="id4"{
                    nonConsumablePurchaseMade4 = true
                    UserDefaults.standard.set(nonConsumablePurchaseMade4, forKey: "nonConsumablePurchaseMade4")
                    
                }
                else if transaction.payment.productIdentifier=="id5"{
                    nonConsumablePurchaseMade5 = true
                    UserDefaults.standard.set(nonConsumablePurchaseMade5, forKey: "nonConsumablePurchaseMade5")
                    
                }
                else if transaction.payment.productIdentifier=="id6"{
                    nonConsumablePurchaseMade6 = true
                    UserDefaults.standard.set(nonConsumablePurchaseMade6, forKey: "nonConsumablePurchaseMade6")
                    
                }
                else if transaction.payment.productIdentifier=="id7"{
                    nonConsumablePurchaseMade7 = true
                    UserDefaults.standard.set(nonConsumablePurchaseMade7, forKey: "nonConsumablePurchaseMade7")
                    
                }
                

                SKPaymentQueue.default().finishTransaction(transaction)
                
            }
 
        }
        
        if atleastOneProductDidRestored
        {
            UIAlertView(title: NSLocalizedString("Restoring!!!", comment: "title"),
                        message: NSLocalizedString("You've successfully restored your purchase!", comment: "message"),
                        delegate: nil, cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
        }
        else
        {
            UIAlertView(title: NSLocalizedString("Sorry !!!", comment: "title"),
                        message: NSLocalizedString("You didn't purchase anything .", comment: "message"),
                        delegate: nil, cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
        }
        
    }
    
    
    
    
    // MARK: - REQUEST IAP PRODUCTS
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {
        
        print("func productsRequest")
        
        if (response.products.count > 0) {
            iapProducts = response.products
            
            print("iapProducts==\(iapProducts)")
            print("response.products==\(response.products)")
            
            // 1st IAP Product (Non-Consumable) ------------------------------------
            let firstProduct = response.products[0] as SKProduct
            
            // Get its price from iTunes Connect
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = firstProduct.priceLocale
            _ = numberFormatter.string(from: firstProduct.price)
            print("firstProduct.productIdentifier=\(firstProduct.productIdentifier)")
            
            
            // ------------------------------------------------
            
            
            
            // 2nd IAP Product (Non-Consumable) ------------------------------
            let secondProd = response.products[1] as SKProduct
            
            // Get its price from iTunes Connect
            numberFormatter.locale = secondProd.priceLocale
            _ = numberFormatter.string(from: secondProd.price)
            print("secondProd.productIdentifier=\(secondProd.productIdentifier)")
            
            // ------------------------------------
            
            // 2nd IAP Product (Non-Consumable) ------------------------------
            let thirdProd = response.products[1] as SKProduct
            
            // Get its price from iTunes Connect
            numberFormatter.locale = thirdProd.priceLocale
            _ = numberFormatter.string(from: thirdProd.price)
            print("secondProd.productIdentifier=\(thirdProd.productIdentifier)")
            
            // ------------------------------------
            
            
            
            
            
            
        }
    }
    
    
    
    
    // MARK: - MAKE PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    func purchaseMyProduct(product: SKProduct) {
        print("func purchaseMyProduct")
        
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            print("payment == \(payment)")
            SKPaymentQueue.default().add(payment)
            
            print("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
            
            
            // IAP Purchases dsabled on the Device
        } else {
            UIAlertView(title: NSLocalizedString("InAppPurchase", comment: "title"),
                        message: NSLocalizedString("Purchases are disabled in your device!", comment: "message"),
                        delegate: nil, cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
        }
    }
    
    
    
    // MARK:- IAP PAYMENT QUEUE
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        print("func paymentQueue")
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                    
                case .purchased:
                    print("purchased")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    
                    // The Consumale product (10 coins) has been purchased -> gain 10 extra coins!
                    if productID == "id1" {
                        
                        nonConsumablePurchaseMade1 = true
                        UserDefaults.standard.set(nonConsumablePurchaseMade1, forKey: "nonConsumablePurchaseMade1")
                        
                        
                        UIAlertView(title: NSLocalizedString("InAppPurchase", comment: "title"),
                                    message: NSLocalizedString("You've successfully unlocked this feature!", comment: "message"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                        
                        
                        
                        // The Non-Consumable product (Premium) has been purchased!
                    }
                    else if productID == "id2" {
                        
                        // Save your purchase locally (needed only for Non-Consumable IAP)
                        nonConsumablePurchaseMade2 = true
                        UserDefaults.standard.set(nonConsumablePurchaseMade2, forKey: "nonConsumablePurchaseMade2")
                        
                        
                        UIAlertView(title: NSLocalizedString("InAppPurchase", comment: "title"),
                                    message: NSLocalizedString("You've successfully unlocked this feature!", comment: "message"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    }
                    else if productID == "id3" {
                        
                        // Save your purchase locally (needed only for Non-Consumable IAP)
                        nonConsumablePurchaseMade3 = true
                        UserDefaults.standard.set(nonConsumablePurchaseMade3, forKey: "nonConsumablePurchaseMade3")
                        
                        
                        UIAlertView(title: NSLocalizedString("InAppPurchase", comment: "title"),
                                    message: NSLocalizedString("You've successfully unlocked this feature!", comment: "message"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    }
                    else if productID == "id4" {
                        
                        // Save your purchase locally (needed only for Non-Consumable IAP)
                        nonConsumablePurchaseMade4 = true
                        UserDefaults.standard.set(nonConsumablePurchaseMade4, forKey: "nonConsumablePurchaseMade4")
                        
                        
                        UIAlertView(title: NSLocalizedString("InAppPurchase", comment: "title"),
                                    message: NSLocalizedString("You've successfully unlocked this feature!", comment: "message"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    }
                    else if productID == "id5" {
                        
                        // Save your purchase locally (needed only for Non-Consumable IAP)
                        nonConsumablePurchaseMade5 = true
                        UserDefaults.standard.set(nonConsumablePurchaseMade5, forKey: "nonConsumablePurchaseMade5")
                        
                        
                        UIAlertView(title: NSLocalizedString("InAppPurchase", comment: "title"),
                                    message: NSLocalizedString("You've successfully unlocked this feature!", comment: "message"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    }
                    else if productID == "id6" {
                        
                        // Save your purchase locally (needed only for Non-Consumable IAP)
                        nonConsumablePurchaseMade6 = true
                        UserDefaults.standard.set(nonConsumablePurchaseMade6, forKey: "nonConsumablePurchaseMade6")
                        
                        
                        UIAlertView(title: NSLocalizedString("InAppPurchase", comment: "title"),
                                    message: NSLocalizedString("You've successfully unlocked this feature!", comment: "message"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    }
                    else if productID == "id7" {
                        
                        // Save your purchase locally (needed only for Non-Consumable IAP)
                        nonConsumablePurchaseMade7 = true
                        UserDefaults.standard.set(nonConsumablePurchaseMade7, forKey: "nonConsumablePurchaseMade7")
                        
                        
                        UIAlertView(title: NSLocalizedString("InAppPurchase", comment: "title"),
                                    message: NSLocalizedString("You've successfully unlocked this feature!", comment: "message"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    }
                    else if productID == "id8" {
                        
                        // Save your purchase locally (needed only for Non-Consumable IAP)
                        nonConsumablePurchaseMade8 = true
                        UserDefaults.standard.set(nonConsumablePurchaseMade8, forKey: "nonConsumablePurchaseMade8")
                        
                        
                        UIAlertView(title: NSLocalizedString("InAppPurchase", comment: "title"),
                                    message: NSLocalizedString("You've successfully unlocked this feature!", comment: "message"),
                                    delegate: nil,
                                    cancelButtonTitle: NSLocalizedString("OK", comment: "title")).show()
                    }
                        
                        
                        
                        
                        
                        
                        
                        
                    else{
                        print("id does not match")
                    }
                    
                    
                    break
                    
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    print("failed")
                    break
                case .restored:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                default: break
                }}}
    }
    
    
    // MARK: - Mail
    
    
    func mail(){
        if( MFMailComposeViewController.canSendMail() ) {
            
            let mailComposer = MFMailComposeViewController()
            let modelName = UIDevice.current.model
            let systemVersion = UIDevice.current.systemVersion
            let message = NSLocalizedString("Compose your message here.", comment: "title")
            let av = NSLocalizedString("App Version:", comment: "title")
            let dm = NSLocalizedString("Device Model:", comment: "title")
            let sv = NSLocalizedString("System Version:", comment: "title")
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
            mailComposer.mailComposeDelegate = self
            //            if selection==5{
            //                readtxt()
            mailComposer.setToRecipients(["scanner@odysseyapps.com"])
            //            }
            //            mailComposer.setSubject("Have you heard a swift?")
            //            mailComposer.setMessageBody("Compose your message here.", isHTML: false)
            
            
            mailComposer.setMessageBody( "<p>\(message)<br><br><br><br><br><br><br><br><br>\(av) \( version!)<br>\(dm) \(modelName)<br>\(sv) \(systemVersion)</p>", isHTML: true)
            
            
            print("mail")
            
            
            
            
            print("aftermail")
            mailComposer.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(mailComposer, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: NSLocalizedString("NO MAIL ACCOUNT", comment: "title"), message: NSLocalizedString("Please check your mail account settings and try again", comment: "title"), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "title"), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func mailToTellAFriend(){
        
        if( MFMailComposeViewController.canSendMail() ) {
            
            let mailComposer = MFMailComposeViewController()
            let sub = NSLocalizedString("Scanner", comment: "title")
            let appLink = NSLocalizedString("App Link", comment: "title")
            let message = NSLocalizedString("I find this app very helpful. I think you may like it too! Check it out:", comment: "title")
            mailComposer.mailComposeDelegate = self
            
            
            mailComposer.setSubject("\(sub)")
            
            
            
            mailComposer.setMessageBody( "<p>\(message)</p><a href='https://itunes.apple.com/US/app/id1192981378'>\(appLink)</a>", isHTML: true)
            
            mailComposer.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: "Icon")!, CGFloat(1.0))!, mimeType: "image/jpeg", fileName:  "test.jpeg")
            
            
            print("mail")
            
            
            
            print("aftermail")
            
            mailComposer.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(mailComposer, animated: true, completion: nil)
            
        }
        else{
            let alert = UIAlertController(title: NSLocalizedString("NO MAIL ACCOUNT", comment: "title"), message: NSLocalizedString("Please check your mail account settings and try again", comment: "title"), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "title"), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Mail cancelled")
            self.dismiss(animated: true, completion: nil)
        //activity6.hideActivityIndicator(self.view)
        case MFMailComposeResult.saved.rawValue:
            print("Mail saved")
            self.dismiss(animated: true, completion: nil)
        //activity6.hideActivityIndicator(self.view)
        case MFMailComposeResult.sent.rawValue:
            print("Mail sent")
            self.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: "✅", message: NSLocalizedString("Successfully Uploaded !", comment: "title"), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "title"), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        case MFMailComposeResult.failed.rawValue:
            //activity6.hideActivityIndicator(self.view)
            self.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: "⚠️", message: NSLocalizedString("Upload Failed !", comment: "title"), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "title"), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("Mail sent failure: %@", [error!.localizedDescription])
        default:
            break
        }
        //        self.dismiss(animated: true, completion: nil)
        
        
    }

    

    
    
    
    
    // MARK: - Communication between ColorViewController and NewViewController
    
    static func helloNewVC(_ image : UIImage) // Communicating self from ColorViewController
    {
       NewViewController.selfCopy.startingImages[NewViewController.selfCopy.scrollView.currentIndex] = image
        NewViewController.selfCopy.scrollView.reloadData()
    }

}

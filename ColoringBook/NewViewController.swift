//
//  NewViewController.swift
//  ColoringBook
//
//  Created by Admin on 2017-09-25.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import UIKit
import FSPagerView

class NewViewController: UIViewController , UIScrollViewDelegate , FSPagerViewDataSource,FSPagerViewDelegate , UITableViewDelegate , UITableViewDataSource{
    
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
        let cultureImages = [#imageLiteral(resourceName: "Culture1.png"),#imageLiteral(resourceName: "Culture2.png")]
        let christmasImages = [#imageLiteral(resourceName: "Christmas1.png")]
        let comoicsImages = [#imageLiteral(resourceName: "shutterstock_390780931-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_327716645-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_328071368-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_396296125-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_449997736-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_398779984-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_285644417-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_389612521-[Converted].png"),#imageLiteral(resourceName: "shutterstock_496343161-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_478145179-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_400313902-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_450844078-[Converted].jpg"),#imageLiteral(resourceName: "shutterstock_281143067-[Converted]1xx.jpg")]
        
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
                tableView.separatorColor = UIColor.clear
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
    
    

    
    
    
    // MARK: - View Controller's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUpperViewHolder()
        
        
        
        //self.extendedLayoutIncludesOpaqueBars = true
        //print(upperViewHolder.frame)
        //print(upperViewHolder.center)
        //print(self.view.center)
        
        //downViewHolder.center = CGPoint(x: 0, y: 0)
        buildDataDictionary()
        NewViewController.selfCopy = self
        
        
    }
    
    var didViewAppeared = false
    override func viewDidAppear(_ animated: Bool) {
         // Cause It works perfect here . Storyboard load here .
        if !didViewAppeared
        {   prepareButtons(forButtonNo: 1)
            setupDownViewHolder()
            didViewAppeared = true
        }
        
        //uploadToFB(#imageLiteral(resourceName: "Photo 8-20-17, 5 36 36 PM.jpg"))
        //uploadToMessenger(#imageLiteral(resourceName: "Photo 8-20-17, 5 36 36 PM.jpg"))
    }
    override func viewWillAppear(_ animated: Bool) {
        //automaticallyAdjustsScrollViewInsets = false
        print(test)
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
        { test = 1
            if let target = segue.destination as? ColorViewController
            {
                target.dataImage = startingImages[scrollView.currentIndex]
                
                //target.newvc = self
                
            }
        }
        
        
        
    }
    
    
    
    
    
    // MARK: - FSPager View Delegates 
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return startingImages.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = startingImages[index]
        //cell.textLabel?.text = "Hello Me"
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool
    {
        return false
    }
    
    
    
    func pagerView(_ pagerView: FSPagerView, didHighlightItemAt index: Int)
    {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldSelectItemAt index: Int) -> Bool
    {
        return false
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int)
    {
        
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
    
    let menuSections = ["Artworks" , "Categories"]
    let menuRows1 = ["My Artworks"]
    let menuRows2 = ["Birds","Animals","Fashion","Culture","Christmas","Comics"]
    
    let settingRows1 = ["In App Purchase"]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !menuDidSelected
        {
            return 2
        }
        else
        {
           return menuSections.count
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !menuDidSelected
        {
            if section == 0
            {
                return settingRows1.count
            }
            else
            {
                return 0
            }
            
        }
        else
        {
            if section == 0
            {
                return menuRows1.count
            }
            else
            {
                return menuRows2.count
            }
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !menuDidSelected
        {
            return 100
        }
        else
        {
            return 60
        }
        
        
    }
   
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("MenuViewCell", owner: self, options: nil)?.first as! MenuViewCell
        
        if !menuDidSelected
        {
            cell.title.text = settingRows1[indexPath.row]
            return cell
        }
        else
        {
            
            if indexPath.section == 0
            {
                cell.title.text = menuRows1[indexPath.row]
                cell.icon.image = UIImage(named: menuRows1[indexPath.row]+".png")
                return cell
                
            }
            else
            {
                cell.title.text = menuRows2[indexPath.row]
                cell.icon.image = UIImage(named: menuRows2[indexPath.row]+".png")
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !menuDidSelected
        {
            return " "
        }
        else
        {
            return menuSections[section]
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !menuDidSelected
        {
            
        }
        else
        {
            if indexPath.section == 0
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
                        self.scrollView.reloadData()
                        self.upDownButtonAction(UIButton(), forEvent: UIEvent())
                    }
                }
            }
            else
            {
                UIView.animate(withDuration: 0.3, animations: { 
                    self.deleteMyArtWorkButton.isHidden = true
                })
                
               startingImages =  dataDictionary[menuRows2[indexPath.row ]]!
                //print(indexPath.row)
                //print(menuRows2[indexPath.row])
                self.scrollView.reloadData()
                upDownButtonAction(UIButton(), forEvent: UIEvent())
            }
        }
    }
    
    
    
    
    static func helloNewVC(_ image : UIImage) // Communicating self from ColorViewController
    {
       NewViewController.selfCopy.startingImages[NewViewController.selfCopy.scrollView.currentIndex] = image
        NewViewController.selfCopy.scrollView.reloadData()
    }

}

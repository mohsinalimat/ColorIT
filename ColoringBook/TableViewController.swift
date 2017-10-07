//
//  TableViewController.swift
//  ColoringBook
//
//  Created by MacBook Pro on 12/20/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let indexArray = ["Drafts" , "Categories", "Colouring Book for Me"]
    let draftArray = ["Drafts"]
    let mainArry = ["Free Daily Pic", "New", "Popular"]
    let categoryArry = ["Christmas", "Culture", "Fashion", "Animals", "Birds", "Comics"]
    let bottomArry = ["Share App", "Rate it", "Invite Friends"]
    
    
    var categoryWiseImages = [String:[UIImage]]()
    
    func initCategoryWiseImages()
    {
        var christmasImages = [UIImage]()
        for i in stride(from: 1, through: 2, by: 1)
        {
            if let image = UIImage(named: "Christmas\(i).png")
            {
                christmasImages.append(image)
            }
        }
        categoryWiseImages["Christmas"] = christmasImages
        
        var cultureImages = [UIImage]()
        for i in stride(from: 1, through: 2, by: 1)
        {
            if let image = UIImage(named: "Culture\(i).png")
            {
                cultureImages.append(image)
            }
        }
        categoryWiseImages["Culture"] = cultureImages
        
        var fashionImages = [UIImage]()
        for i in stride(from: 1, through: 2, by: 1)
        {
            if let image = UIImage(named: "Fashion\(i).png")
            {
                fashionImages.append(image)
            }
        }
        categoryWiseImages["Fashion"] = fashionImages
        
        var animalsImages = [UIImage]()
        for i in stride(from: 1, through: 2, by: 1)
        {
            if let image = UIImage(named: "Animals\(i).png")
            {
                animalsImages.append(image)
            }
        }
        categoryWiseImages["Animals"] = animalsImages
        
        var birdsImages = [UIImage]()
        for i in stride(from: 1, through: 2, by: 1)
        {
            if let image = UIImage(named: "Birds\(i).png")
            {
                birdsImages.append(image)
            }
        }
        categoryWiseImages["Birds"] = birdsImages
        
        var comicsImages = [UIImage]()
        for i in stride(from: 1, through: 2, by: 1)
        {
            if let image = UIImage(named: "Comics\(i).png")
            {
                comicsImages.append(image)
            }
        }
        categoryWiseImages["Comics"] = comicsImages
        
        
        
    }
    
    

    @IBOutlet weak var menuTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        initCategoryWiseImages()
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return indexArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexArray[section]
    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return indexArray
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0
        {
            return 1
        }
        else if section == 1
        {
            return mainArry.count
        }
        else if section == 2
        {
            return categoryArry.count
        }
        else
        {
            return bottomArry.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell

        cell.imgView.image = UIImage(named: "more")
        // Configure the cell...
        if indexPath.section == 0
        {
            cell.labelName.text = draftArray[indexPath.row]
        }
        else if indexPath.section == 1
        {
            cell.labelName.text = mainArry[indexPath.row]
        }
        else if indexPath.section == 2
        {
            cell.labelName.text = categoryArry[indexPath.row]
        }
        else if indexPath.section == 3
        {
            cell.labelName.text = bottomArry[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let drawerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC") as! ViewController
        drawerVC.contentImages = [UIImage()]
        
        if indexPath.section == 0
        {
            
        }
        else if indexPath.section == 1
        {
            drawerVC.data = mainArry[indexPath.row]
        }
        else if indexPath.section == 2
        {
            drawerVC.data = categoryArry[indexPath.row]
            //print(categoryArry[indexPath.row])
            //print(categoryWiseImages["Christmas"]!)
            drawerVC.contentImages = categoryWiseImages[categoryArry[indexPath.row]] as! NSMutableArray
            
        }
        else if indexPath.section == 3
        {
            drawerVC.data = bottomArry[indexPath.row]
        }
        
        self.present(drawerVC, animated: false, completion: nil)
    }
   
    

    /*
    //  Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  TabViewController.swift
//  ColoringBook
//
//  Created by MacBook Pro on 12/19/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

import UIKit



class TabViewController: UITabBarController {

    @IBOutlet weak var optionTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // [Maybe you don't have a navigation controller] yNavBar indicates the height of the navigation bar.
        //let yNavBar = self.navigationController?.navigationBar.frame.size.height
        // yStatusBar indicates the height of the status bar
        //let yStatusBar = UIApplication.shared.statusBarFrame.size.height
        // Set the size and the position in the screen of the tab bar
        optionTabBar.frame = CGRect(x: 0, y: 0, width: optionTabBar.frame.size.width, height: optionTabBar.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.tabBarController?.selectedIndex = 2
        tabBarController?.tabBar.selectedItem = tabBarController?.tabBar.items?[2]
    }
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
    }
    
    // UITabBarControllerDelegate
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("Selected view controller")
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

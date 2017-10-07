//
//  SettingsViewController.swift
//  ColoringBook
//
//  Created by MacBook Pro on 12/21/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func popUpAction(_ sender: Any) {
        
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpId") as! PopUpViewController
        //addChildViewController(popUpVC)
        //popUpVC.view.frame = (self.view.superview?.frame)!
        //self.view.addSubview(popUpVC.view)
        //popUpVC.didMove(toParentViewController: self)
        self.present(popUpVC, animated: false, completion: nil)
        
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

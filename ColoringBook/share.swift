//
//  FaceBook.swift
//  ColoringBook
//
//  Created by Odyssey Apps on 10/18/17.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import Foundation
import FacebookShare
import FBSDKMessengerShareKit
import FacebookCore
extension  SharingViewController
{
    
    func uploadToFB()
    {
        let photo = Photo(image:  self.coloredImageView.image! , userGenerated: true)
        
        do
        {
            var content = PhotoShareContent(photos: [photo])
            content.hashtag = Hashtag("#ColoringBook")
            let dialog = ShareDialog(content: content)
            dialog.presentingViewController = self
            //dialog.mode = .native // if you don't set this before canShow call, canShow would always return YES
            
            try dialog.show()
            //try ShareDialog.show(from: self , content: hashtag)
        }
        catch
        {
            print("Error on facebook share")
        }
        
    }
    
    func uploadToMessenger()
    {
        
        // Objective C Version
        /*UIImage *image = [UIImage imageNamed:@"selfie_pic"];
         [FBSDKMessengerSharer shareImage:image withOptions:nil];*/
        //FBSDKMessengerShareOptions options = FBSDKMessengerShareOptions()
        FBSDKMessengerSharer.share(self.coloredImageView.image, with: nil)
        
        // Another Way But crashed while no Messenger App
        /*let photo = Photo(image:  self.coloredImageView.image! , userGenerated: true)
        var content = PhotoShareContent(photos: [photo])
        content.hashtag = Hashtag("#ColoringBook")
        let messageDialog = MessageDialog(content: content)
        do
        {
         try messageDialog.show()
        }
        catch
        {
         print("Error . . . .. ")
        }*/
        
    }
    func airdrop(){
        let controller = UIActivityViewController(activityItems: [self.coloredImageView.image!], applicationActivities: nil)
        controller.excludedActivityTypes = [UIActivityType.print, UIActivityType.assignToContact]
        
        self.present(controller, animated: true, completion: nil)
    }
    func uploadToInstagram(){
        
        let appName = "instagram"
        let appScheme = "\(appName)://"
        let appUrl = URL(string: appScheme)
        
        if UIApplication.shared.canOpenURL(appUrl! as URL)
        {
            UIApplication.shared.open(appUrl!)
            
        } else {
            
            //-----------------------
            HelperMethods.Alerts(VC: self, header: "Get Instagram", message: "Get instagram for this feature", btn1Name: "Install", btn2Name: "Not Now", handlerBtn1: { () -> Void in
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string :"https://itunes.apple.com/us/app/instagram/id389801252?mt=8")!)
                }
                else {
                    UIApplication.shared.openURL(URL(string :"https://itunes.apple.com/us/app/instagram/id389801252?mt=8")!)
                }
            })
            //-------------------------
        }
    }

    
}

//
//  DataMGMT.swift
//  BCScanner2
//
//  Created by Admin on 2017-05-03.
//  Copyright © 2017 com.odyssey. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataMGMT
{
    
    static func  extractImagesFromDraft () -> (images : [UIImage], data : [Draft])
    {
        var dataArray = [Draft]()
        do
        {
            let newCon = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
            var request = NSFetchRequest<NSFetchRequestResult>()
            request = Draft.fetchRequest()
            request.returnsObjectsAsFaults = false
            dataArray = try newCon.fetch(request) as! [Draft]
            
            //print(dataArray)
            
         
            
        }
        catch
        {
            
        }
        
        var imageArray = [UIImage]()
        for data in dataArray
        {
            imageArray.append(UIImage(data: data.image! as Data)!)
        }
        
       
        
        return (imageArray,dataArray)
    }
    
    
    
    
    static func saveImageToDraft(_ image : UIImage)
    {
        
            
            let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
            let data = Draft( context: context)
            data.image = UIImagePNGRepresentation(image)! as NSData
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}




/*
extension XDATA
{ //okkk
    
    func getTextNImage() -> (String , UIImage? , UIImage? )
    {
        var text = ""
        var frontPhoto  : UIImage? = nil
        var backPhoto  :UIImage? = nil
        
        if self.name != nil && self.name != " "
        {
            text.append("Name : " + self.name!  + "\n")
        }
        if self.jobTitle != nil && self.jobTitle != " "
        {
            text.append("Designation : " + self.jobTitle!  + "\n")
        }
        if self.company != nil && self.company != " "
        {
            text.append("Company : " + self.company!  + "\n")
        }
        if self.experience != nil && self.experience != " "
        {
            text.append("Experince : " + self.experience!  + "\n")
        }
        if self.street1 != nil && self.street1 == " "
        {
            text.append("Street1 : " + self.street1!  + "\n")
        }
        if self.street2 != nil && self.street2 == " "
        {
            text.append("Street2 : " + self.street2!  + "\n")
        }
        if self.city != nil && self.city != " "
        {
            text.append("City : " + self.city!  + "\n")
        }
        if self.postcode != nil && self.postcode == " "
        {
            text.append("Postcode : " + self.postcode!  + "\n")
        }
        if self.state != nil && self.state == " "
        {
            text.append("State : " + self.state!  + "\n")
        }
        if self.country != nil && self.country != " "
        {
            text.append("Country : " + self.country!  + "\n")
        }
        
       
        if self.birthDay != nil && self.birthDay != " "
        {
            text.append("Birthday : " + self.birthDay!  + "\n")
        }
        
        if self.email != nil && self.email != " "
        {
            text.append("Email : " + self.email!  + "\n")
        }
        
        if self.phone != nil && self.phone != " "
        {
            text.append("Phone : " + self.phone!  + "\n")
        }
        
        
        
        if self.website != nil && self.website == " "
        {
            text.append("Web : " + self.website!  + "\n")
        }
        
        
        
        
        
        
        if self.backPhoto != nil
        {
            backPhoto = UIImage(data: self.backPhoto! as Data)
        }
        if self.frontPhoto != nil
        {
            frontPhoto = UIImage(data: self.frontPhoto! as Data)
        }
        
       
        
        return (text ,frontPhoto, backPhoto)
        
    }
 
    
    
}
*/











//
//  DatabaseController.swift
//  ColoringBook
//
//  Created by Odyssey Apps on 9/19/17.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import Foundation
struct customWheels {
    var number : Int64
    var name : String
    var col1 : String
    var col2 : String
    var col3 : String
    var col4 : String
    var col5 : String
    var col6 : String
    var col7 : String
    var col8 : String
}
var generatedWheels = [customWheels]()
class DatabaseController{
    
    
    static func setValueToDataBase(no: Int64, name: String, col1: String, col2: String, col3: String, col4: String, col5:String, col6:String, col7:String, col8:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newWheel = NSEntityDescription.insertNewObject(forEntityName: "Wheel", into: context)
        newWheel.setValue(no, forKey: "number")
        newWheel.setValue(name, forKey: "name")
        newWheel.setValue(col1, forKey: "col1")
        newWheel.setValue(col2, forKey: "col2")
        newWheel.setValue(col3, forKey: "col3")
        newWheel.setValue(col4, forKey: "col4")
        newWheel.setValue(col5, forKey: "col5")
        newWheel.setValue(col6, forKey: "col6")
        newWheel.setValue(col7, forKey: "col7")
        newWheel.setValue(col8, forKey: "col8")
        
        do{
            try context.save()
            print("SAVED")
            generatedWheels.append(customWheels(number: no , name: name , col1: col1 , col2: col2 , col3: col3 , col4: col4 , col5: col5 , col6: col6 , col7: col7 , col8: col8 ))
            
        }
        catch{
            print("Error \(error)")
        }
        
        
    }
    static func fetchDataFromDataBase(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Wheel")
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                //generatedWheels.removeAll()
                for result in results as! [NSManagedObject]
                {
                    let wheelNo = result.value(forKey: "number")
                    
                    let wheelName = result.value(forKey: "name")
                    
                    let col1 = result.value(forKey: "col1")
                    
                    let col2 = result.value(forKey: "col2")
                    
                    let col3 = result.value(forKey: "col3")
                    
                    let col4 = result.value(forKey: "col4")
                    
                    let col5 = result.value(forKey: "col5")
                    
                    let col6 = result.value(forKey: "col6")
                    
                    let col7 = result.value(forKey: "col7")
                    
                    let col8 = result.value(forKey: "col8")
                
                    //print(result)
                    generatedWheels.append(customWheels(number: wheelNo as! Int64, name: wheelName as! String, col1: col1 as! String, col2: col2 as! String, col3: col3 as! String, col4: col4 as! String, col5: col5 as! String, col6: col6 as! String, col7: col7 as! String, col8: col8 as! String))
                }
                
            }
        }
        catch{
            print("Error \(error)")
        }
        
    }
    static func editDataFromDatabase(number: Int64, name: String, col1: String, col2: String, col3: String, col4: String, col5:String, col6:String, col7:String, col8:String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Wheel")
        request.predicate = NSPredicate(format: "number = %ld", number)
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                let managedObject = results[0]
                //(managedObject as AnyObject).setValue(number, forKey: "number")
                (managedObject as AnyObject).setValue(col1, forKey: "col1")
                (managedObject as AnyObject).setValue(col2, forKey: "col2")
                (managedObject as AnyObject).setValue(col3, forKey: "col3")
                (managedObject as AnyObject).setValue(col4, forKey: "col4")
                (managedObject as AnyObject).setValue(col5, forKey: "col5")
                (managedObject as AnyObject).setValue(col6, forKey: "col6")
                (managedObject as AnyObject).setValue(col7, forKey: "col7")
                (managedObject as AnyObject).setValue(col8, forKey: "col8")
                
                try context.save()
                
                generatedWheels[number-80] = customWheels(number: number , name: name , col1: col1 , col2: col2 , col3: col3 , col4: col4 , col5: col5 , col6: col6 , col7: col7 , col8: col8 )
            }
        }
        catch{
            print("Error \(error)")
        }
                
    }
    static func deleteDataFromDatabase(number: Int64, arrayIndx: Int64){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Wheel")
        request.predicate = NSPredicate(format: "number = %ld", number)
        //request.returnsObjectsAsFaults = false
        do{
            if let result = try? context.fetch(request)
            {
                for object in result{
                    context.delete(object as! NSManagedObject)
                }
                
                do{
                    try context.save()
                }
                catch{
                    print("Error \(error)")
                }
                print("asdf\(number)")
                generatedWheels.remove(at: arrayIndx-80)
                //print("asdf\(generatedWheels.count)")
                //print("asdf\(generatedWheels[1])")
                
            }
        }
        
    }

    
}

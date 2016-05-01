//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Val Baca on 4/28/16.
//  Copyright © 2016 Val Baca. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        // "Users" matches the Entity name
        let   newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        newUser.setValue("Kirsten", forKey: "username") // these match the attributes
        newUser.setValue("1234", forKey: "password")
        
        do {
            try context.save()
        } catch _ {
            print("error saving")
        }
        
        let request = NSFetchRequest(entityName: "Users")
        request.predicate = NSPredicate(format: "username = %@", "Kirsten")
        
        do {
            let results = try context.executeFetchRequest(request)
            print(results)
            
            if (results.count > 0) {
                for result : AnyObject in results {
                    if let user = result.valueForKey("username") as? String {
                        print(user)
                        if user == "Kirsten" { // this is redundant at this point...
//                            context.deleteObject(result as! NSManagedObject) // delete
                            result.setValue("newpass", forKey: "password") // update
                            try context.save()
//                            print("user has been deleted!")
                            print("user's password has been updated")
                        }
                    }
                }
            }
        } catch _ {
            print("error executing request")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


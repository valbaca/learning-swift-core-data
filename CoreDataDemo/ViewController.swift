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
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        newUser.setValue("FooBar", forKey: "username") // these match the attributes
        newUser.setValue("1234", forKey: "password")
        
        do {
            try context.save()
        } catch _ {
            print("error saving")
        }
        
        let request = NSFetchRequest(entityName: "Users")
        
        do {
            let results = try context.executeFetchRequest(request)
            print(results)
        } catch _ {
            print("error executing request")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  EditVC.swift
//  ContactAppUsingCoreData
//
//  Created by Raju Gupta on 13/12/19.
//  Copyright © 2019 Raju Gupta. All rights reserved.
//

import UIKit
import  CoreData

class EditVC: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    var name : String?
    var phone : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Update Contact"
        txtName.text = name
        txtPhoneNumber.text = phone
        
    }
    
    @IBAction func onClickUpdate(_ sender: Any)
    {
        fetch()
    }
    
    func fetch()
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let contex = appDel.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Contact")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name!)
        
        do
        {
            let singleContact = try contex.fetch(fetchRequest) as! [NSManagedObject]
            
            let objectToUpdate = singleContact[0]
            objectToUpdate.setValue("\(txtName.text!)", forKey: "name")
            objectToUpdate.setValue("\(txtPhoneNumber.text!)", forKey: "phoneNumber")
            
            do
            {
                try contex.save()
                performSegue(withIdentifier: "backTohome", sender: self)
                //navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("failed")
            }
            
            
        }
        catch
        {
            print("failed")
        }
    }
    
   

}

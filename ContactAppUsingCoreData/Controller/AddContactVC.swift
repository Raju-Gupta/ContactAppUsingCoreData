//
//  AddContactVC.swift
//  ContactAppUsingCoreData
//
//  Created by Raju Gupta on 11/12/19.
//  Copyright © 2019 Raju Gupta. All rights reserved.
//

import UIKit
import CoreData

class AddContactVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblResult.isHidden = true
        navigationItem.title = "Add Contact"
        
    }
    
    

    @IBAction func onClickSave(_ sender: Any)
    {
        if txtName.text?.count == 0 && txtPhoneNumber.text?.count == 0
        {
            lblResult.text = "Both Field Are Required !"
            lblResult.textColor = UIColor.red
            lblResult.isHidden = false
        }
        else
        {
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let contex = appDel.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Contact", in: contex)
            let newContact = NSManagedObject(entity: entity!, insertInto: contex)
            
            newContact.setValue("\(txtName.text!)", forKey: "name")
            newContact.setValue("\(txtPhoneNumber.text!)", forKey: "phoneNumber")
            
            do
            {
                try contex.save()
                navigationController?.popViewController(animated: true)
                
                
            }
            catch
            {
                lblResult.text = "failed to save contact."
                lblResult.textColor = UIColor.red
                lblResult.isHidden = false
                print("failed to save contact.")
            }
        }
        
    }
    
    
}

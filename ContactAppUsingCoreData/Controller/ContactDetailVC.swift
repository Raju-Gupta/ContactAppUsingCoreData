//
//  ContactDetailVC.swift
//  ContactAppUsingCoreData
//
//  Created by Raju Gupta on 13/12/19.
//  Copyright © 2019 Raju Gupta. All rights reserved.
//

import UIKit
import CoreData

class ContactDetailVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    
    var name : String = ""
    var phone : String = ""
    var rowNumber :[NSManagedObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contact Detail"
        lblName.text = name
        lblPhoneNumber.text = phone
    }
    
    @IBAction func onClickDelete(_ sender: Any)
    {
        fetch()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickEdit(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(identifier: "EditVC") as! EditVC
        vc.name = name
        vc.phone = phone
        navigationController?.pushViewController(vc, animated: true)
    }
    func fetch()
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let contex = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do
        {
            let singleContact = try contex.fetch(fetchRequest) as! [NSManagedObject]
            
            let objectToDelete = singleContact[0]
            contex.delete(objectToDelete)
            
            do
            {
                try contex.save()
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

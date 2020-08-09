//
//  ContactListTVC.swift
//  ContactAppUsingCoreData
//
//  Created by Raju Gupta on 11/12/19.
//  Copyright © 2019 Raju Gupta. All rights reserved.
//

import UIKit
import CoreData

class ContactListTVC: UITableViewController{
    
    var allContact = [NSManagedObject]()
    @IBOutlet var tableV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetch()
        tableV.reloadData()
    }
    
    func fetch()
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let contex = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        
        do
        {
            allContact = try contex.fetch(fetchRequest) as! [NSManagedObject]
            
            for result in allContact as! [NSManagedObject]
            {
                print("name=== \(result.value(forKey: "name") as! String)")
                print("phoneNumber=== \(result.value(forKey: "phoneNumber") as! String)")
            }
            
        }
        catch
        {
            print("failed")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allContact.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTVC", for: indexPath)
        let contact = allContact[indexPath.row]
        cell.textLabel?.text = contact.value(forKey: "name") as? String
        cell.detailTextLabel?.text = contact.value(forKey: "phoneNumber") as? String
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowNumber = allContact[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(identifier: "ContactDetailVC") as! ContactDetailVC
        vc.name = rowNumber.value(forKey: "name") as! String
        vc.phone = rowNumber.value(forKey: "phoneNumber") as! String
        vc.rowNumber = [rowNumber]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func unwindToHome(segue : UIStoryboardSegue)
    {
        tableV.reloadData()
    }
    

   

}

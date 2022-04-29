//
//  ContactListViewController.swift
//  MasterDetail(SplitView)-ContactsApp
//
//  Created by Macbook Air on 29.04.2022.
//

import UIKit

class ContactListViewController: UITableViewController {

    
    var contacts : [Contact] = ContactSource.contacts
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"
        cell.imageView?.image = contact.image
        cell.detailTextLabel?.text = contact.email
        return cell
    }
    

}

//
//  TableViewController.swift
//  MyPhotoList
//
//  Created by Macbook Air on 23.05.2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    
    var fetchResultController : NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // will fetch the data
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        //brings data sorted from a to z
        let sorter = NSSortDescriptor(key: "titletext", ascending: true)
        
        fetchRequest.sortDescriptors = [sorter]

        return fetchRequest
    }
    
    func getFetchResultController() -> NSFetchedResultsController<NSFetchRequestResult>{
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: persistentContainer, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.backgroundColor = UIColor.systemPink
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
        
        fetchResultController = getFetchResultController()
        fetchResultController.delegate = self
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error.localizedDescription)
            return
        }
        self.tableView.reloadData()
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let numberOfRows = fetchResultController.sections?[section].numberOfObjects
        return numberOfRows!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let dataRow = fetchResultController.object(at: indexPath) as! Entity
        cell.titleLabel.text = dataRow.titletext
        cell.descriptionLabel.text = dataRow.descriptiontext
        cell.imagePhoto.image = UIImage(data: dataRow.image!)
        return cell
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let selectedCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: selectedCell)
            
            let addPhotoVC : addAPhotoViewController = segue.destination as! addAPhotoViewController
            let selectedItem : Entity = fetchResultController.object(at: indexPath!) as! Entity
            addPhotoVC.selectedItem = selectedItem
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let managedObject : NSManagedObject = fetchResultController.object(at: indexPath) as! NSManagedObject
        persistentContainer.delete(managedObject)
        
        do {
            try persistentContainer.save()
        } catch {
            print(error)
            return
        }
        
    }

}

//
//  stopTableViewController.swift
//  Assignment_7
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit
import CoreData

class StopTableViewController: UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate{
    var managedContext: NSManagedObjectContext!
    let searchController = UISearchController(searchResultsController: nil)
    var searchResultsController: NSFetchedResultsController<Stop>!
    let stopCoreData = StopCoreData()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let editButton = self.editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItems = [editButton,addButton]
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type stop's name here to search"
        navigationItem.searchController = searchController
        self.definesPresentationContext = true
        let app = UIApplication.shared.delegate as! AppDelegate
        managedContext = app.persistentContainer.viewContext
        searchResultsController = stopCoreData.getStops(managedContext: managedContext)
        searchResultsController.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(isFiltering()){
            return searchResultsController.fetchedObjects!.count
        }else{
            guard let stops = stopCoreData.getStops(managedContext: managedContext).fetchedObjects else {return 0}
            return stops.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var object = ""
        if(isFiltering()){
            object = searchResultsController.object(at: indexPath).name!
        }else{
            let stops = stopCoreData.getStops(managedContext: managedContext)
            object = stops.object(at: indexPath).name!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath)
        
        cell.textLabel?.text = object
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        //create a method to ilter the objects
        filterContentForSearchText(text)
    }
    
    func filterContentForSearchText(_ searchText: String){
        
        let namePredicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText.lowercased())
        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [namePredicate])
        
        searchResultsController!.fetchRequest.predicate = predicate
        do {
            try searchResultsController!.performFetch()
        }
        catch {
            fatalError("Error in fetching records")
        }
        tableView.reloadData()
    }
    
    @objc func insertNewObject(_ sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StopDetailVC") as! StopDetailViewController
        vc.title = "Create New Stop"
        vc.btnTitle = "Create"
        self.navigationController?.show(vc, sender: self)
    }
    
    func isFiltering() -> Bool {
        return (searchController.isActive && !(searchController.searchBar.text?.isEmpty)!)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(isFiltering()){
                let stop = searchResultsController.object(at: indexPath)
                managedContext.delete(stop)
                do{
                    try managedContext.save()
                }catch {
                    print("Some thing went wrong \(error.localizedDescription)")
                }
                do{
                    try searchResultsController.performFetch()
                }catch {
                    fatalError("Error in fetching records")
                }
            }else{
                // Delete the row from the data source
                let stop = stopCoreData.getStops(managedContext: managedContext).object(at: indexPath)
                managedContext.delete(stop)
                do{
                    try managedContext.save()
                }catch {
                    print("Some thing went wrong \(error.localizedDescription)")
                }
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showStopDetailSegue"{
            let indexPath = tableView.indexPathForSelectedRow!
            let vc = segue.destination as! StopDetailViewController
            vc.title = "Edit Stop Details"
            vc.btnTitle = "Update"
            if isFiltering() {
                vc.stop = searchResultsController.object(at: indexPath)
            }
            else {
                vc.stop = stopCoreData.getStops(managedContext: managedContext).object(at: indexPath)
            }
        }
    }

}

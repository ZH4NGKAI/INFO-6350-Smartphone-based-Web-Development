//
//  ScheduleTableViewController.swift
//  Assignment_7
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController, UISearchResultsUpdating {
    var filtedObjs:[Schedule] = [Schedule]()
    var train = Train()
    let searchController = UISearchController(searchResultsController: nil)
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
        searchController.searchBar.placeholder = "Type schedule's id here to search"
        navigationItem.searchController = searchController
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
            return filtedObjs.count
        }else{
            return train.schedules.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var object = 0
        if(isFiltering()){
            object = filtedObjs[indexPath.row].id
        }else{
            object = train.schedules[indexPath.row].id
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath)
        
        cell.textLabel?.text = String(object)
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        //create a method to ilter the objects
        filterContentForSearchText(text)
    }
    
    func filterContentForSearchText(_ searchText: String){
        
        filtedObjs = train.schedules.filter({ (schedule:Schedule) -> Bool in
            if (searchController.searchBar.text?.isEmpty)! {
                return true
            }else {
                return schedule.id == Int(searchText)
            }
        })
        tableView.reloadData()
    }
    
    @objc func insertNewObject(_ sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ScheduleDetailVC") as! ScheduleDetailViewController
        vc.title = "Create New Stop"
        vc.btnTitle = "Create"
        vc.train = self.train
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
            // Delete the row from the data source
            train.schedules.remove(at: indexPath.row)
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
        if segue.identifier == "showScheduleDetailSegue"{
        //            let indexPath = tableView.indexPathForSelectedRow
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let vc = segue.destination as! ScheduleDetailViewController
            vc.title = "Edit Schedule Details"
            vc.btnTitle = "Update"
            if isFiltering() {
                vc.schedule = filtedObjs[indexPath!.row]
                
            }
            else {
                vc.schedule = train.schedules[indexPath!.row]
            }
            vc.train = train
        }
    }

}

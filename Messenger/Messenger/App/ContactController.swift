//
//  ContactController.swift
//  Messenger
//
//  Created by mac on 4/23/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//

import UIKit
import CometChatPro

class ContactController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var userRequest = UsersRequest.UsersRequestBuilder(limit: 20).build()
    var searchController = UISearchController(searchResultsController: nil)
    var users: [User] = [User]()
    var filteredUsers: [User] = [User]()
    var sectionTitle : UILabel?
    var sections = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        if users.isEmpty {
             refreshUsers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = false
//        navigationItem.title = NSLocalizedString("Contacts", comment: "")
//        navigationItem.largeTitleDisplayMode = .automatic
        
        self.setupSearchBar()
        self.fetchUsers()
        
    }
    
    
    func setupSearchBar(){
        // SearchBar Apperance
        searchController.searchResultsUpdater = self
//        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
//        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        userRequest = UsersRequest.UsersRequestBuilder(limit: 20).set(searchKeyword: searchController.searchBar.text!).build()
        userRequest.fetchNext(onSuccess: { (users) in
           if users.count != 0 {
               self.filteredUsers = users
               DispatchQueue.main.async(execute: {self.tableView.reloadData()})
           }
        }) { (error) in
           print("error while searching users: \(String(describing: error?.errorDescription))")
        }
    }
    
    func refreshUsers(){
        self.sections.removeAll()
        self.users.removeAll()
        tableView.tableFooterView?.isHidden = false
        userRequest = UsersRequest.UsersRequestBuilder(limit: 20).build()
        userRequest.fetchNext(onSuccess: { (users) in
            print("fetchUsers onSuccess: \(users)")
            if users.count != 0 {
                self.users = self.users.sorted(by: { (Obj1, Obj2) -> Bool in
                    let Obj1_Name = Obj1.name ?? ""
                    let Obj2_Name = Obj2.name ?? ""
                    return (Obj1_Name.localizedCaseInsensitiveCompare(Obj2_Name) == .orderedAscending)
                })
                
                self.users.append(contentsOf: users)
                DispatchQueue.main.async {
                    self.tableView.tableFooterView?.isHidden = true
                    self.tableView.reloadData()
                }
            }
            DispatchQueue.main.async {
                self.tableView.tableFooterView?.isHidden = true}
        }) { (error) in
            DispatchQueue.main.async {
                if let errorMessage = error?.errorDescription {
                  let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: errorMessage, duration: .short)
                    snackbar.show()
                }
            }
            print("fetchUsers error:\(String(describing: error?.errorDescription))")
        }
    }
    
    func fetchUsers(){
        tableView.tableFooterView?.isHidden = false
        userRequest.fetchNext(onSuccess: { (users) in
            print("fetchUsers onSuccess: \(users)")
            if users.count != 0 {
                self.users = self.users.sorted(by: { (Obj1, Obj2) -> Bool in
                    let Obj1_Name = Obj1.name ?? ""
                    let Obj2_Name = Obj2.name ?? ""
                    return (Obj1_Name.localizedCaseInsensitiveCompare(Obj2_Name) == .orderedAscending)
                })
                
                self.users.append(contentsOf: users)
                DispatchQueue.main.async {
                    self.tableView.tableFooterView?.isHidden = true
                    self.tableView.reloadData()
                }
            }
            DispatchQueue.main.async {
                self.tableView.tableFooterView?.isHidden = true}
        }) { (error) in
            DispatchQueue.main.async {
                if let errorMessage = error?.errorDescription {
                  let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: errorMessage, duration: .short)
                    snackbar.show()
                }
            }
            print("fetchUsers error:\(String(describing: error?.errorDescription))")
        }
    }
    
    func isSearching() -> Bool {
        return (searchController.isActive && !(searchController.searchBar.text?.isEmpty)!)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching() {
            if filteredUsers.count != 0 {
                for user in filteredUsers {
                    if !sections.contains((user.name?.first?.uppercased())!){
                        sections.append(String((user.name?.first?.uppercased())!))
                    }
                }
            }
            return sections.count
        }else{
            if users.count != 0 {
                for user in users {
                    if !sections.contains((user.name?.first?.uppercased())!){
                        sections.append(String((user.name?.first?.uppercased())!))
                    }
                }
            }
            return sections.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isSearching(){
            return filteredUsers.count
        }else{
            return users.count
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSearching(){
            return 0
        }else{
            return 25
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        var user: User?
        if isSearching() {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        print("user : \(String(describing: user?.stringValue()))")
        if sections[indexPath.section] == user?.name?.first?.uppercased(){
            let userCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) 
            userCell.textLabel?.text = user?.name
            return userCell
        }else{
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.frame.size.width, bottom: 0, right: 0)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isSearching() {
            let user = filteredUsers[indexPath.row]
            if sections[indexPath.section] == user.name?.first?.uppercased(){
                return 60
            }else{
                return 0
            }
        }else{
            let user = users[indexPath.row]
            if sections[indexPath.section] == user.name?.first?.uppercased(){
                return 60
            }else{
                return 0
            }
           
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        sectionTitle = UILabel(frame: CGRect(x: 10, y: 2, width: view.frame.size.width, height: 25))
        sectionTitle?.text = self.sections[section]
        if #available(iOS 13.0, *) {
            sectionTitle?.textColor = .lightGray
            returnedView.backgroundColor = .systemBackground
        } else {}
        returnedView.addSubview(sectionTitle!)
        return returnedView
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            self.fetchUsers()
        }
    }
    
    override public func tableView(_ tableView: UITableView,
                          sectionForSectionIndexTitle title: String,
                          at index: Int) -> Int{
        return index
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        if segue.identifier == "chatViewSegue"{
            
            let indexPath = tableView.indexPathForSelectedRow!
            let vc = segue.destination as! ChatViewController
            if isSearching() {
                vc.receiver = filteredUsers[indexPath.row]
            }
            else {
                vc.receiver = users[indexPath.row]
            }
        }
    }
    

}

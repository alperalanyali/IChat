//
//  UserTVC.swift
//  IChat
//
//  Created by Alper on 12.11.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD
import SDWebImage





class UserTVC: UITableViewController {
 
    

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    
    
    var allObjects = [String]()
    var allAvatars = [String]()
    var allPhones = [String]()
    var findingCities = [String]()
    var findingCountries = [String]()
    var findingCitiesAvatar = [String]()
    
    var currentUserCity = String()
    var currentUserCountry = String()
    var currentUserUID = String()
    var currentUserFullname = String()
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        currentUserUID = (Auth.auth().currentUser?.uid)!
//        print("Current User UID: \(String(describing: currentUserUID))")
       findCurrentUser()
        loadUsers()
        filterSegmentControl.selectedSegmentIndex = 2
        
    
        
    }

    //MARK: IBActions

    @IBAction func filterSegmentValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:

            loadUsers()
            print("APO: Selected Segment Index: 0, \(findingCities) ")
            
        case 1:

            loadUsers()
            print("APO: Selected Segment Index: 1 \(findingCountries)")

        default:

            loadUsers()
           print("APO: Selected Segment Index: 2  \(allObjects)")

        }
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filterSegmentControl.selectedSegmentIndex == 0 {
            return findingCities.count
        } else if filterSegmentControl.selectedSegmentIndex == 1 {
            return findingCountries.count
        } else {
            return allObjects.count
        }
    
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
        if filterSegmentControl.selectedSegmentIndex == 0 {
             cell.fullnameLabel.text = findingCities[indexPath.row]
            cell.avatarImage.sd_setImage(with: URL(string: allAvatars[indexPath.row]), completed: nil)
        } else if filterSegmentControl.selectedSegmentIndex == 1 {
            cell.fullnameLabel.text = findingCountries[indexPath.row]
            cell.avatarImage.sd_setImage(with: URL(string: allAvatars[indexPath.row]), completed: nil)
        } else if filterSegmentControl.selectedSegmentIndex == 2 {
             cell.fullnameLabel.text = allObjects[indexPath.row]
            cell.avatarImage.sd_setImage(with: URL(string: allAvatars[indexPath.row]), completed: nil)
        }
      
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileView") as! ProfileTVC
        self.navigationController?.pushViewController(profileVC, animated: true)
        profileVC.avatar = allAvatars[indexPath.row]
        profileVC.userFullName = allObjects[indexPath.row]
        profileVC.phoneNumber = allPhones[indexPath.row]
        
    }
 
    //    MARK: Getting data from Firebase
    
    func loadUsers(){
        ProgressHUD.show()

        self.findingCountries = []
        self.findingCities = []
        self.allObjects = []
        
        Database.database().reference(withPath:"Users").observe(.value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                print(snapshots)
                
//                self.tableView.reloadData()
                ProgressHUD.dismiss()
                
                for snap in snapshots {
                    if let userDic = snap.value as? [String: AnyObject]{
                        
                        
                        
                        
                        
                        if self.filterSegmentControl.selectedSegmentIndex == 0 {
                            if let findCity = userDic["city"]{
                                if self.currentUserCity == findCity as! String {
                                    if self.currentUserFullname != userDic["fullname"] as! String{
                                        self.findingCities.append(userDic["fullname"] as! String)
                                        print("Users as same as current User's City: \(self.findingCities)")
                                    }
                                }
                            }
                        }
                       
                        
                        if self.filterSegmentControl.selectedSegmentIndex == 1{
                          
                            if let findCountry = userDic["country"]{
                                if self.currentUserCountry == findCountry as! String{
                                    if self.currentUserFullname != userDic["fullname"] as! String{
                                        self.findingCountries.append(userDic["fullname"] as! String)
                                    }
                                }
                            }
                        }
                       
                            
                        if self.filterSegmentControl.selectedSegmentIndex == 2 {
                            
                            if let fullname = userDic["fullname"] {
                                
                                if self.currentUserFullname != fullname  as! String{
                                    
                                    self.allObjects.append(fullname as! String)
                                    print("APO: All Fullname: \(self.allObjects)")
                                }
                                
                                
                            }
                           
                        }
                        
                     self.tableView.reloadData()
                        
                        if let avatarImage = userDic["avatar"]{
                            self.allAvatars.append(avatarImage as! String)
                            print("All Avatar Image URL: \(self.allAvatars)")
                        }
                        if let phone = userDic["phone"]{
                            self.allPhones.append(phone as! String)
                            print("All Phone Number: \(self.allPhones)")
                        }
                    }
                }
            }
        }
    }
    
    //    MARK: Finding Current User from Firebase Database
    
    func findCurrentUser(){
        Database.database().reference(withPath:"Users").observe(.value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshots {
                    if self.currentUserUID == snap.key {
                        if let currentUserDic = snap.value as? [String: AnyObject] {
                            if let currentCity = currentUserDic["city"]{
                                self.currentUserCity = currentCity as! String
                                print("CurrentUser City : \(self.currentUserCity)")
                            }
                            if let currentCountry = currentUserDic["country"] {
                                self.currentUserCountry = currentCountry as! String
                                print("CurrentUser Country: \(self.currentUserCountry)")
                            }
                         
                        }
                        
                    }
                }
            }
        }
    }

    
    
}


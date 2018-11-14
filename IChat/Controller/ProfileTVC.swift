//
//  ProfileTVC.swift
//  IChat
//
//  Created by Alper on 14.11.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ProfileTVC: UITableViewController {

    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var messageButtonOutlet: UIButton!
    @IBOutlet weak var callButtonOutlet: UIButton!
        @IBOutlet weak var blockButtonOutlet: UIButton!
    @IBOutlet weak var avatarImage: CustomImage!
    
    
    var userFullName: String!
    var avatar: String!
    var phoneNumber: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("User Full Name:\(String(describing: userFullName))")
        print("Avatar: \(String(describing: avatar))")
        print("Phone Number: \(String(describing: phoneNumber))")
        setupUI()
  
    }
    //MARK: IBActions
    
    @IBAction func callButtonPressed(_ sender: Any) {
        
        print("Call User \(String(describing: userFullName))")
    }
    
    @IBAction func messageButtonPressed(_ sender: Any) {
        print("Chat with User \(String(describing: userFullName))")
    }
    @IBAction func blockUserButtonPressed(_ sender: Any) {
        print("Blocking User \(String(describing: userFullName))")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 30
    }
    
    //    MARK: Setup UI
    
    func setupUI(){
        if !(userFullName?.isEmpty)!{
            self.title = "Profile"
            fullnameLabel.text = userFullName!
            if let avatarURL = avatar {
                avatarImage!.sd_setImage(with: URL(string: avatarURL), completed: nil)
            }
            
            phoneLabel.text = phoneNumber!
           
        }
    }

}

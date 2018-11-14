//
//  ChatTVC.swift
//  IChat
//
//  Created by Alper on 9.11.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class ChatTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    
    @IBAction func createNewChatButtonPressed(_ sender: Any) {
        
        let userVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserTableView") as! UserTVC
        self.navigationController?.pushViewController(userVC, animated: true)
       
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        

        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


  

}

//
//  SettingsVC.swift
//  IChat
//
//  Created by Alper on 9.11.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutBtnPressed(_ sender: Any) {
        ProgressHUD.show("Loging Out")
        UserDefaults.standard.removeObject(forKey: "CurrentUser")
        UserDefaults.standard.synchronize()
        do {
            try Auth.auth().signOut()
            self.showLoginView()
            ProgressHUD.dismiss()
            
        } catch let error as NSError {
            ProgressHUD.showError(error.localizedDescription)
        }
        
        
    }
    func showLoginView(){
        
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sigIn")
        
        self.present(mainView, animated: true, completion: nil)
    }
}

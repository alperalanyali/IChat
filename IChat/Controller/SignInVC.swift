//
//  ViewController.swift
//  IChat
//
//  Created by Alper on 8.11.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD





class SignInVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: IBActions
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        if emailField.text! != "" && passwordField.text! != "" && repeatPasswordField.text! != "" {
            if passwordField.text! == repeatPasswordField.text! {
                registerUser()
            } else {
                ProgressHUD.showError("Passwords do not match!")
            }
        } else {
            ProgressHUD.showError("Email and Password are required!")
        }
        
        
    }
    
    
    @IBAction func logInBtnPressed(_ sender: Any) {
        dismissKeyboard()
        if emailField.text != "" && passwordField.text != "" {
            loginUser()
        } else {
            ProgressHUD.showError("Email and Password are required.")
        }
        
       
    }

    
    func loginUser(){
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
            } else {
                
                self.goToApp()
            }
        }
    }
    
    @IBAction func backgroundTap(_ sender: Any) {
        dismissKeyboard()
    }
    //    MARK: Helper Functions
    
    func dismissKeyboard(){
        self.view.endEditing(false)
    }
    func cleanTextFields(){
        emailField.text! = ""
        passwordField.text! = ""
        repeatPasswordField.text! = ""
        
    }
    
    func registerUser(){
        performSegue(withIdentifier: "signIntoFinishRegistration", sender: nil)
        dismissKeyboard()
        cleanTextFields()
    }
    
    //    MARK:Go to App
    
    func goToApp(){
        
        UserDefaults.standard.set(self.emailField.text!, forKey: "CurrentUser")
        UserDefaults.standard.synchronize()
        
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApplication") as! UITabBarController
        present(mainVC, animated: true, completion: nil)
        
        
    }
    
    
    //    MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signIntoFinishRegistration"{
            let vc = segue.destination as! FinishRegistrationVC
            vc.email = self.emailField.text!
            vc.password = self.passwordField.text!
        }
    }
    
}


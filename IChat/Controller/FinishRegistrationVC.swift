    //
    //  FinishRegistrationVC.swift
    //  IChat
    //
    //  Created by Alper on 8.11.2018.
    //  Copyright © 2018 Alper. All rights reserved.
    //
    
    import UIKit
    import Firebase
    import FirebaseAuth
    import FirebaseStorage
    import ProgressHUD
    
    


    
    class FinishRegistrationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @IBOutlet weak var avatarImage: CustomImage!
        @IBOutlet weak var firstnameField: UITextField!
        @IBOutlet weak var lastnameField: UITextField!
        @IBOutlet weak var countryField: UITextField!
        @IBOutlet weak var cityField: UITextField!
        @IBOutlet weak var phoneField: UITextField!
        
        var email:String!
        var password: String!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let dismissKeyboardGS = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(dismissKeyboardGS)
            
            avatarImage.isUserInteractionEnabled = true
            let choosePhotoGS = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
            avatarImage.addGestureRecognizer(choosePhotoGS)
        }
        
        @IBAction func doneBtnPressed(_ sender: Any) {
            ProgressHUD.show("Registering...")
            dismissKeyboard()
            if !firstnameField.text!.isEmpty && !lastnameField.text!.isEmpty && !countryField.text!.isEmpty && !cityField.text!.isEmpty && !phoneField.text!.isEmpty {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error != nil {
                        ProgressHUD.showError(error!.localizedDescription)
                    } else {
                        
                        self.registerUser()
                    }
                }
                
            } else {
                ProgressHUD.showError("All Fields are required!!")
            }
            
            
            
            
            
            
        }
        
        @IBAction func cancelBtnPressed(_ sender: Any) {
            dismissKeyboard()
            cleanTextFields()
            dismiss(animated: true, completion: nil)
        }
        
        
        
        //        MARK: Helper Function
        
        func registerUser(){
            
            let fullname = firstnameField.text! + " " + lastnameField.text!
           
            
            let avatarImageFolder = Storage.storage().reference().child("avatarImage")
            if let avatarData = avatarImage.image?.jpegData(compressionQuality: 0.7){
                let uuid = NSUUID().uuidString
                let avatarImageRef = avatarImageFolder.child("\(uuid).jpeg")
                avatarImageRef.putData(avatarData, metadata: nil) { (metadata, error) in
                    if error != nil {
                        ProgressHUD.showError(error!.localizedDescription)
                    } else {
                        avatarImageRef.downloadURL(completion: { (url, error) in
                            if error == nil {
                                let avatarURL = url?.absoluteString
//                                print("ImageURL: \(avatarURL!)")
                                let currentUser = Auth.auth().currentUser!
                              
                               
                                print("CurrentUser: \(currentUser)")
                                let avatarDic : Dictionary = [kFIRSTNAME: self.firstnameField.text!,kLASTNAME: self.lastnameField.text!,kFULLNAME: fullname, kCITY: self.cityField.text!, kCOUNTRY: self.countryField.text!,kPHONE: self.phoneField.text!,kAVATAR: avatarURL!,kEMAIL: self.email!] as [String:Any]
//                                print("APO: Avatar Dic: \(avatarDic)")
                                Database.database().reference().child("Users").child(currentUser.uid).setValue(avatarDic)
                                self.goToApp()
                                
                                ProgressHUD.dismiss()
                                
                            }
                            
                        })
                        
                    }
                    
                }
                
            }
            
            
        }
      
        
        func goToApp(){
            
            cleanTextFields()
            dismissKeyboard()
            
            let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApplication")
            present(mainView, animated: true, completion: nil)
            
        }
        @objc func dismissKeyboard() {
            self.view.endEditing(false)
        }
        func cleanTextFields(){
            avatarImage.image = UIImage(named: "avatarPlaceHolder")
            [firstnameField,lastnameField,countryField,cityField,phoneField].forEach{$0?.text = "" }
        }
        @objc func choosePhoto(){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            avatarImage.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
